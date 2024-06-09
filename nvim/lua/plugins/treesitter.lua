return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = "all",
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "tmux" }, -- Tmux TS looks weird
            },
            indent = { enable = true },
        })
    end
}
