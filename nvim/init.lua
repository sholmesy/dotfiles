-- Path to lazy nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy nvim is installed, if not, clone it
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

-- Add to start of runtimepath
vim.opt.runtimepath:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup("plugins", {
    change_detection = { notify = false }
})
