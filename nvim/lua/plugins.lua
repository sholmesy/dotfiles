-- Ordered by most likely to be a dependency
vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/sainnhe/gruvbox-material" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    {
        src = "https://github.com/neovim/nvim-lspconfig",
        version = "v2.0.0"
    },
    {
        src = "https://github.com/Saghen/blink.cmp",
        version = "v1.6.0",
    },
    { src = "https://github.com/stevearc/oil.nvim" },
    {
        src = "https://github.com/folke/snacks.nvim",
        opts = {
            dim = { enabled = true },
            explorer = { enabled = true },
            gitbrowse = { enabled = true },
            git = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            scroll = { enabled = true },
            words = { enabled = true },
        }
    },
    { src = "https://github.com/zbirenbaum/copilot.lua" },
    { src = "https://github.com/folke/trouble.nvim" },
    { src = "https://github.com/j-hui/fidget.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/tpope/vim-rhubarb" },
})

require("fidget").setup()

require("oil").setup()

require("blink.cmp").setup({
    keymap = { preset = "super-tab" },
    appearance = { nerd_font_variant = "mono" },
    completion = {
        menu = { border = "rounded" },
        documentation = { window = { border = "rounded" } },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
        prebuilt_binaries = { force_version = "v1.6.0" },
    },
})

require("nvim-treesitter.configs").setup({
    sync_install = false,
    ignore_install = {},
    ensure_installed = { "lua", "go", "python", "yaml" },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    modules = {},
})

require("trouble").setup()

require("copilot").setup({
    filetypes = { markdown = false },
    suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = false,
        debounce = 50,
        trigger_on_accept = true,
        keymap = {
            accept = "<C-Enter>",
            accept_word = false,
            accept_line = "<C-q>",
            next = "<C-s>",
            prev = "<C-p>",
            dismiss = "<C-x>",
        },
    },
})

-- LSP
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Include the capabilities from blink.cmp
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

local gopls_config = {
    capabilities = capabilities,
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    settings = {
        gopls = {
            analyses = {
                ST1000 = false,
                ST1003 = false,
                nilness = true,
                shadow = true,
                unusedparams = true,
                unusedwrite = true,
            },
            staticcheck = true,
            expandWorkspaceToModule = false,
            ["local"] = "***", -- Commented out company
        },
    },
    cmd = { "env", "GO111MODULE=off", "gopls", "-remote=auto" },
    root_dir = function(startpath)
        local root_markers = { "README.md", "main.go", "go.mod", "LICENSE", ".git" }
        local matches = vim.fs.find(root_markers, {
            path = startpath,
            upward = true,
            limit = 1,
        })
        if #matches == 0 then
            return vim.fs.dirname(vim.fs.find(".git", { path = startpath, upward = true })[1])
        end
        local root_dir = vim.fn.fnamemodify(matches[1], ":p:h")
        return root_dir
    end,
    ignoredRootPaths = { "***" }, -- Commented out company
    memoryMode = "DegradeClosed",
    flags = { debounce_text_changes = 500 },
    init_options = {
        codelenses = {
            generate = true,
            gc_details = true,
            test = true,
            tidy = true,
        },
    },
}

local lua_ls_config = {
    capabilities = capabilities,
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
    settings = {
        Lua = {
            diagnostics = {
                disable = { "missing-fields" },
                globals = { "vim", "Snacks", "Presenting" },
            },
        },
    },
}

local yaml_ls_config = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
    root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
    end,
    single_file_support = true,
    settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
            format = {
                enable = true,
            },
            schemas = {
                -- Commented out company
            },
        },
    },
}

local servers = {
    gopls = gopls_config,
    lua_ls = lua_ls_config,
    yamlls = yaml_ls_config,
}


local lspconfig = require('lspconfig')

for server, config in pairs(servers) do
    lspconfig[server].setup(config)
end

vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    {
        pattern = "*.go",
        callback = function(data)
            local clients = vim.lsp.get_clients { name = "gopls" }
            if #clients > 0 then
                local client = clients[1]
                vim.lsp.buf.code_action {
                    id = client.id,
                    bufnr = data.buf,
                    context = { only = { "source.organizeImports" } },
                    apply = true,
                }
                vim.lsp.buf.format { id = client.id, bufnr = data.buf }
            end;
        end,
    }
)
