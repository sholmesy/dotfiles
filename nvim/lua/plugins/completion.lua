-- For autocomplete/previews, gets out of the way more, does a popover instead of on the line
vim.opt.completeopt = "menuone,noinsert,noselect"

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        -- Luasnip is the expansion engine
        "L3MON4D3/LuaSnip",

        -- Rest are "sources"
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        -- Cmp setup covers the in-editor experience
        cmp.setup({
            -- Snippet expansion, tells `cmp` to call `lsp_expand` with the content
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            -- Styling of the pop up window
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            -- Keymaps for selecting suggestions
            mapping = cmp.mapping.preset.insert({
                ["<Right>"] = cmp.mapping.confirm({ select = true }),
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


    end
}

