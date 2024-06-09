-- Highlights matching parenthesis/symbols
vim.opt.showmatch = true

-- Ignore case sensitivity for searches, unless you start putting case in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    event = "VeryLazy",
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-s>', function() builtin.find_files({ hidden = true }) end, {})
        vim.keymap.set('n', '<C-f>', function() builtin.live_grep({ hidden = true }) end, {})
        vim.keymap.set('n', '<C-b>', builtin.buffers, {})
        vim.keymap.set('n', '<C-m>', builtin.help_tags, {})
        vim.keymap.set('n', '<C-h>', builtin.command_history, {})
    end
}
