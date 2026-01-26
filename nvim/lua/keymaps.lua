-- Note for command consistency:
-- Use <leader> format for normal mode commands.
-- Use <C-...> format for insert mode commands.

-- Mapleader, prefix for commands.
vim.g.mapleader = " "

vim.keymap.set("v", "<leader>cc", function() vim.cmd.normal("gc") end, { desc = "Comment Block" })
vim.keymap.set("n", "<leader>cc", function() vim.cmd.normal("gc_") end, { desc = "Comment Line" })

-- Window navigation
vim.keymap.set("n", "<leader>ww", function() vim.cmd.wincmd("w") end, { desc = "Window Previous" })
vim.keymap.set("n", "<leader>wh", function() vim.cmd.wincmd("h") end, { desc = "Window Left" })
vim.keymap.set("n", "<leader>wj", function() vim.cmd.wincmd("j") end, { desc = "Window Down" })
vim.keymap.set("n", "<leader>wk", function() vim.cmd.wincmd("k") end, { desc = "Window Up" })
vim.keymap.set("n", "<leader>wl", function() vim.cmd.wincmd("l") end, { desc = "Window Right" })

-- Window commands
vim.keymap.set("n", "<leader>||", function() vim.cmd("vsplit") end, { desc = "Window Vertical Split" })
vim.keymap.set("n", "<leader>\\\\", function() vim.cmd("split") end, { desc = "Window Horizontal Split" })
vim.keymap.set("n", "<leader>wq", function() vim.cmd("quit") end, { desc = "Quit" })

-- Jumplist navigation
vim.keymap.set("n", "<leader>b", "<C-o>", { desc = "Previous Jumplist Item" })

-- Oil
vim.keymap.set({ "n" }, "<leader>ee", "<CMD>Oil<CR>", { desc = "Open Parent Directory" })

-- Config reload
vim.keymap.set({ "n" }, "<leader>s", "<CMD>source<CR>", { desc = "Source Config" })

-- LSP
vim.keymap.set({ "n" }, "<leader>lh", vim.lsp.buf.hover, { desc = "LSP Hover" })
vim.keymap.set({ "n" }, "<leader>lr", vim.lsp.buf.references, { desc = "LSP References" })
vim.keymap.set({ "n" }, "<leader>ld", vim.lsp.buf.definition, { desc = "LSP Definition" })
vim.keymap.set({ "n" }, "<leader>lc", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
vim.keymap.set({ "n" }, "<leader>li", vim.lsp.buf.implementation, { desc = "LSP Implementation" })
vim.keymap.set({ "n" }, "<leader>lf", vim.lsp.buf.format, { desc = "LSP Format" })
vim.keymap.set({ "n" }, "<leader>ln", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- Trouble
vim.keymap.set({ "n" }, "<leader>tt", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Toggle Trouble Diagnostics" })

-- Picker
vim.keymap.set(
    "n",
    "<leader>ff",
    Snacks.picker.smart,
    { desc = "Find Files" }
)
vim.keymap.set(
    "n",
    "<leader>fg",
    Snacks.picker.grep,
    { desc = "Find Grep" }
)
vim.keymap.set(
    "n",
    "<leader>fb",
    Snacks.picker.buffers,
    { desc = "Find Buffers" }
)
vim.keymap.set(
    "n",
    "<leader>fh",
    Snacks.picker.help,
    { desc = "Find Helptags" }
)
vim.keymap.set(
    "n",
    "<leader>fc",
    function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = "Find Config" }
)
