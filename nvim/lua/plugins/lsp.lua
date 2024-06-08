-- Show quick docs in hover
vim.keymap.set("n", "<C-i>", vim.lsp.buf.hover, {})

-- Go to definition
vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, {})

-- Autocommands
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function()
        vim.lsp.buf.format()
    end
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
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "gopls" },
                automatic_installation = true,
            })
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                -- Lua
                ["lua_ls"] = function()
                    require("lspconfig")["lua_ls"].setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = { disable = { 'missing-fields' } },
                            }
                        }
                    })
                end,
                -- Go
                ["gopls"] = function()
                    require("lspconfig")["gopls"].setup({
                        capabilities = capabilities,
                    })
                end,
                -- Python
                ["jedi_language_server"] = function()
                    require("lspconfig")["jedi_language_server"].setup({
                        capabilities = capabilities,
                    })
                end,
            })
        end
    },
}
