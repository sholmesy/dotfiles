vim.g.copilot_no_tab_map = true
vim.g.copilot_no_insert_map = true
vim.g.copilot_enabled = false

return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            local chat = require("CopilotChat")
            local settings = {
                auto_insert_mode = true,
                mappings = { complete = { insert = "" } },
                model = "gpt-4",
                window = {
                    layout = "horizontal",
                    width = 1,
                    height = 0.4,
                }
            }
            chat.setup(settings)
            vim.keymap.set({ "n", "v" }, "<C-o>", function()
                chat.toggle()
            end)
        end,
    },
}
