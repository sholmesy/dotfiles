-- Window/buffer management, don"t close unsaved windows when navigating away
vim.opt.hidden = true

-- Set number of lines between bottom of screen and viewport
vim.opt.scrolloff = 3

-- Trigger Explorer
vim.keymap.set("n", "<C-e>", ":Explore<CR>", {})

-- Quit
vim.keymap.set("n", "<C-q>", ":quit<CR>", {})

return {}
