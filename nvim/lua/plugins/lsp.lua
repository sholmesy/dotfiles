-- Show quick docs in hover
vim.keymap.set("n", "<C-i>", vim.lsp.buf.hover, {})

-- Go to definition
vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, {})

-- Show references
vim.keymap.set("n", "<C-k>", vim.lsp.buf.references, {})

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

-- Lsp pretty popups
local border_config = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = border_config
    }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = border_config
    }
)
vim.diagnostic.config({
    signs = false,
    border = true,
    float = { border = border_config },
})


return {
    "neovim/nvim-lspconfig",
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig",
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "gopls", "jedi_language_server" },
                automatic_installation = true,
            })
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    local lspconfig = require("lspconfig")
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig["lua_ls"].setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = { disable = { "missing-fields" } },
                            }
                        }
                    })
                end,
                ["gopls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig["gopls"].setup({
                        capabilities = capabilities,
                        settings = {
                            gopls = {
                                analyses = {
                                    fieldalignment = true,
                                    nilness = true,
                                    shadow = true,
                                    unusedparams = true,
                                    unusedwrite = true,
                                },
                                staticcheck = true,
                                expandWorkspaceToModule = false,
                                -- Organize imports. Groups imports by Monzo versus not-Monzo.
                                -- Equivalent to local flag with goimports
                                ["local"] = "github.com/monzo/wearedev",
                            },
                        },
                        cmd = { "/Users/samholmes/.local/bin/gopls.sh", "-remote=auto" },
                        -- Treat anything containing these files as a root directory. This
                        -- prevents us ascending too far toward the root of the repository, which
                        -- stops us from trying to ingest too much code.
                        root_dir = function(startpath)
                            local root_markers = { "README.md", "main.go", "go.mod", "README.md", "LICENSE", ".git" }
                            local matches = vim.fs.find(root_markers, {
                                path = startpath,
                                upward = true,
                                limit = 1,
                            })

                            -- If there are no matches, fall back to finding the Git ancestor.
                            if #matches == 0 then
                                return lspconfig.util.find_git_ancestor(startpath)
                            end

                            local root_dir = vim.fn.fnamemodify(matches[1], ':p:h')
                            return root_dir
                        end,

                        -- Never use wearedev as a root path. It'll grind your machine to a halt.
                        ignoredRootPaths = { "$HOME/src/github.com/monzo/wearedev/" },

                        -- Collect less information about packages without open files.
                        memoryMode = "DegradeClosed",

                        flags = {
                            -- gopls is a particularly slow language server, especially in wearedev.
                            -- Debounce text changes so that we don't send loads of updates.
                            debounce_text_changes = 500,
                        },

                        init_options = {
                            codelenses = {
                                generate = true,
                                gc_details = true,
                                test = true,
                                tidy = true,
                            },
                        },
                    })
                end,
                ["jedi_language_server"] = function()
                    require("lspconfig")["jedi_language_server"].setup({
                        capabilities = capabilities,
                    })
                end,
            })
        end
    },
}
