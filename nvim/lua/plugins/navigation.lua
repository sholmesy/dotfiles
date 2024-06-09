-- Window/buffer management, don"t close unsaved windows when navigating away
vim.opt.hidden = true

-- Set number of lines between bottom of screen and viewport
vim.opt.scrolloff = 3

-- Trigger Explorer
vim.keymap.set("n", "<C-e>", ":Explore<CR>", {})

-- Remap Netrw bindings
vim.api.nvim_create_autocmd('filetype', {
    pattern = 'netrw',
    callback = function()
        local bind = function(lhs, rhs)
            vim.keymap.set('n', lhs, rhs, { remap = true, buffer = true })
        end
        -- Navigate back to previous directory
        bind('=', 'u')

        -- Navigate to directory
        bind('<C-]>', 'gn')
    end
})

-- Quit
vim.keymap.set("n", "<C-q>", ":quit<CR>", {})

-- Buffer toggling
vim.keymap.set("n", "<C-p>", ":bprev<CR>", {})
vim.keymap.set("n", "<C-n>", ":bnext<CR>", {})

return {}
