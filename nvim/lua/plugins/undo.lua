-- Don't use a swap file for open files
vim.opt.swapfile = false

-- Use undodir to store file changes
vim.opt.undofile = true
vim.opt.undodir = "/home/sam/.local/state/nvim/undodir"

return {}
