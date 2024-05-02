-- Options
--
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmatch = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.linebreak = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.showtabline = 0
vim.opt.backup = false
vim.opt.smartindent = true
vim.opt.lazyredraw = true
vim.opt.undofile = true
vim.opt.undodir = "/Users/samholmes/.vim/undodir"
vim.opt.hidden = true
vim.opt.scrolloff = 3
vim.g.mapleader = " "
vim.g.netrw_altfile = 1
vim.g.copilot_no_tab_map = true
vim.g.copilot_enabled = false
vim.opt.winminheight = 0
vim.opt.winminwidth = 0
vim.opt.autochdir = true
vim.g.netrw_keepdir = 0

-- Plugins
require("packer").startup(function(use)
    use("wbthomason/packer.nvim")                                 -- Plugin manager
    use("nvim-lua/plenary.nvim")                                  -- Base requirement
    use("kyazdani42/nvim-web-devicons")                           -- Icons
    use("rose-pine/neovim")                                       -- Color scheme
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- Treesitter
    use("williamboman/mason.nvim")                                -- LSP/DAP/Linter package manager
    use("williamboman/mason-lspconfig.nvim")                      -- Mason <-> LSP bridge
    use("neovim/nvim-lspconfig")                                  -- Default configs for LSPs
    use("hrsh7th/nvim-cmp")                                       -- Completion engine
    use("hrsh7th/cmp-nvim-lsp")                                   -- Completion for LSPs
    use("hrsh7th/cmp-buffer")                                     -- Completion for buffers
    use("hrsh7th/cmp-path")                                       -- Completion for filesystem paths
    use("hrsh7th/cmp-cmdline")                                    -- Completion for command line
    use("L3MON4D3/LuaSnip")                                       -- Snippet engine for completion
    use("terrortylor/nvim-comment")                               -- Commenting
    use("tpope/vim-fugitive")                                     -- Git stuff
    use("windwp/windline.nvim")                                   -- Statusline
    use("folke/trouble.nvim")                                     -- Diagnostics
    use("numToStr/Navigator.nvim")                                -- Tmux navigation
    use("szw/vim-maximizer")                                      -- Maximizer
    use("junegunn/fzf")                                           -- Fuzzy search
    use("github/copilot.vim")                                     -- Copilot
    use({
        "CopilotC-Nvim/CopilotChat.nvim",
        requires = { { 'github/copilot.vim' }, { "nvim-lua/plenary.nvim" } }
    }) -- Copilot chat
    use({
        "junegunn/fzf.vim",
        rtp = "/opt/hombrew/bin/fzf",
    }) -- Fuzzy finder
end)

-- Use SQL filetype for Cassandra files, until a good LSP exists
vim.filetype.add({ extension = { cql = "sql" } })

-- Colors & Icons
require("nvim-web-devicons").setup()
require("rose-pine").setup({})
require("wlsample.airline")
vim.cmd("colorscheme rose-pine")

-- Completion
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    completion = { completeopt = "noselect" },
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping({
        ["<Right>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping(function()
            cmp.complete()
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    }),
})

-- Use buffer source w/ cmp for `/` search
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use command source w/ cmp for `:` commands
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "cmdline" },
    },
})

-- Trouble
local trouble = require("trouble")

-- Copilot Chat
require("CopilotChat").setup()

-- Other
require("nvim-treesitter.configs").setup({
    ensure_installed = "all",      -- Install all treesitters
    auto_install = true,           -- Force install if not already
    highlight = { enable = true }, -- Use TS highlighting
    modules = {},
    sync_install = false,
    ignore_install = {}
})

-- Comment
local comment = require("nvim_comment")
comment.setup({
    line_mapping = "<leader>cc",
    operator_mapping = "cc",
})

-- Autocommands
-- Python
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    {
        pattern = "*.py",
        callback = function()
            vim.lsp.buf.format()
        end
    }
)

-- Lua
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    {
        pattern = "*.lua",
        callback = function()
            vim.lsp.buf.format()
        end
    }
)


-- Go
vim.api.nvim_create_autocmd(
    { "BufWritePre" },
    {
        pattern = "*.go",
        callback = function()
            vim.lsp.buf.format()
            local params = vim.lsp.util.make_range_params()
            params.context = { only = { "source.organizeImports" } }
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
            for cid, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                        vim.lsp.util.apply_workspace_edit(r.edit, enc)
                    end
                end
            end
        end
    }
)


-- LSP setups

-- Mason for LSP package management
local mason = require("mason")
mason.setup()

-- MasonLSPConfig helps bridge the gap between Mason & nvim-lspconfig
local masonlspconfig = require("mason-lspconfig")
masonlspconfig.setup()

-- LSP Config for default configs
local lspconfig = require("lspconfig")

-- Setup completion capabilities
local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())



-- Custom setup LSP commands for MasonLSPConfig servers
masonlspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({})
    end,
    ["gopls"] = function()
        lspconfig.gopls.setup({
            capabilities = cmp_capabilities,
        })
    end,
    ["jsonls"] = function()
        lspconfig.jsonls.setup({
            capabilities = cmp_capabilities,
        })
    end,
    ["jedi_language_server"] = function()
        lspconfig.jedi_language_server.setup({
            capabilities = cmp_capabilities,
        })
    end,
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
            capabilities = cmp_capabilities,
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim", "require" } },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = { enable = false },
                },
            },
        })
    end
})


-- Keymaps
require("Navigator").setup()

-- Navigation
-- These should be mimic"d in `.tmux.conf` to ensure that the same navigation
-- can be used between tmux/terminal and tmux/nvim
--
local prefix = "<M-"
local suffix = ">"

if vim.g.neovide then
    prefix = "<D-"
    vim.o.guifont = "JetBrainsMono Nerd Font Mono:h18"
    vim.g.neovide_cursor_animation_length = 0.05
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_scroll_animation_length = 0.2
    vim.g.neovide_scroll_animation_far_lines = 5
    vim.g.neovide_hide_mouse_when_typing = true

    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 50
    vim.g.neovide_padding_left = 50
else
    vim.keymap.set({ "n", "t" }, "<M-x>", "<C-o><CR>")
end

vim.keymap.set({ "n", "t" }, prefix .. "[" .. suffix, "<CMD>NavigatorLeft<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "]" .. suffix, "<CMD>NavigatorRight<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "{" .. suffix, "<CMD>NavigatorUp<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "}" .. suffix, "<CMD>NavigatorDown<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "\\" .. suffix, "<CMD>vsplit<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "|" .. suffix, "<CMD>split<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "=" .. suffix, "<CMD>vertical resize +5<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "-" .. suffix, "<CMD>vertical resize -5<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "+" .. suffix, "<CMD>resize +5<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "_" .. suffix, "<CMD>resize -5<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "o" .. suffix, "<CMD>MaximizerToggle<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "e" .. suffix, "<CMD>Explore<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "t" .. suffix, "<CMD>tabnew<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "1" .. suffix, "<CMD>tabnext 1<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "2" .. suffix, "<CMD>tabnext 2<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "3" .. suffix, "<CMD>tabnext 3<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "4" .. suffix, "<CMD>tabnext 4<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "f" .. suffix, "<CMD>:Rg<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "b" .. suffix, "<CMD>:Buffers<CR>")
vim.keymap.set({ "n", "t" }, prefix .. "d" .. suffix, "<CMD>:FZF<CR>")
vim.keymap.set({ "n", "t" }, ">>", "<CMD>cd %:h<CR>")
vim.keymap.set({ "t" }, "<ESC>", "<C-\\><C-n>")
vim.keymap.set({ "i" }, "<C-s>", "<Plug>(copilot-suggest)")
vim.keymap.set({ "i" }, "<C-]>", "<Plug>(copilot-next)")
vim.keymap.set({ "i" }, "<C-a>", "<Plug>(copilot-accept-line)")
vim.keymap.set({ "i" }, "<C-l>", "<Plug>(copilot-accept-word)")
vim.keymap.set({ "v", "n" }, "<C-h>", "<CMD>:CopilotChat<CR>")
vim.keymap.set({ "v", "n" }, "<C-e>", "<CMD>:CopilotChatExplain<CR>")

-- Diagnostics
vim.keymap.set({ "n" }, "T", function() trouble.toggle("document_diagnostics") end)
vim.keymap.set({ "n" }, "D", vim.lsp.buf.definition)
vim.keymap.set({ "n" }, "R", vim.lsp.buf.references)
vim.keymap.set({ "n" }, "H", vim.lsp.buf.hover)
