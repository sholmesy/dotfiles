-- System clipboard
vim.opt.clipboard = "unnamedplus"

-- For autocomplete/previews, gets out of the way more, does a popover instead of on the line
vim.opt.completeopt = "menuone,noinsert,noselect"

-- Allows mapping termguicolors for colorschemes
vim.opt.termguicolors = true

-- Default to dark background
vim.opt.background = "dark"

-- Theme colors
vim.g.gruvbox_material_enable_italic = true
vim.g.gruvbox_material_background = "hard"
vim.cmd.colorscheme("gruvbox-material")
vim.cmd.highlight("statusline guibg=NONE")

-- Converts tabs to spaces
vim.opt.expandtab = true

-- Set the indentation width
vim.opt.shiftwidth = 4

-- Set the render width of tabs
vim.opt.tabstop = 4

-- Syntax aware indenting
vim.opt.smartindent = true

-- Window/buffer management, close unsaved windows when navigating away
vim.opt.hidden = true
vim.opt.showtabline = 0

-- Set number of lines between bottom of screen and viewport
vim.opt.scrolloff = 3

-- Set laststatus to 3 = status line will always be on the left
vim.opt.laststatus = 0

-- Focus the vim splits when they are created
vim.opt.splitright = true
vim.opt.splitbelow = true

-- No minimum height/width for windows
vim.opt.winminheight = 0
vim.opt.winminwidth = 0

-- Highlights matching parenthesis/symbols
vim.opt.showmatch = true

-- Ignore case sensitivity for searches, unless you start putting case in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Don't use a swap file for open files
vim.opt.swapfile = false

-- Use undodir to store file changes
vim.opt.undofile = true
vim.opt.undodir = "/Users/samholmes/.local/state/nvim/undodir"

-- Pretty window borders
vim.opt.winborder = "rounded"

-- Copilot settings
-- vim.g.copilot_no_tab_map = true
-- vim.g.copilot_no_insert_map = true
-- vim.g.copilot_enabled = true
-- vim.g.copilot_filetypes = { markdown = false }
