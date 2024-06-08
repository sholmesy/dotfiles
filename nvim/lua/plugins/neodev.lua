-- Adds neovim completions for plugin development (e.g vim globals)
return {
    "folke/neodev.nvim",
    priority = 1000,
    config = function()
        require("neodev").setup({})
    end
}
