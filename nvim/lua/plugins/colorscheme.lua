-- Settings for the colorscheme of the editor

-- Allows mapping termguicolors for colorschemes
vim.opt.termguicolors = true

-- Default to dark background
vim.opt.background = "dark"

return {
    {
        "sainnhe/gruvbox-material",
        config = function()
            vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_material_background = "hard"
            vim.cmd.colorscheme("gruvbox-material")
        end
    },
    {
        "windwp/windline.nvim",
        config = function()
            require("wlsample.airline")
        end
    },
}
