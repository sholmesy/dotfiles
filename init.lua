-- luacheck: globals vim

-- Options
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmatch = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.linebreak = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.backup = false
vim.opt.smartindent = true
vim.opt.lazyredraw = true
vim.opt.undofile = true
vim.opt.undodir = "/Users/samholmes/.vim/undodir"
vim.opt.hidden = true
vim.opt.scrolloff = 3
vim.g.mapleader = " "

-- Plugins
require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- Plugin manager
	use("nvim-lua/plenary.nvim") -- Base requirement
	use("kyazdani42/nvim-web-devicons") -- Icons
	use("rose-pine/neovim") -- Color scheme
	use({ -- Treesitter
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("norcalli/nvim-colorizer.lua") -- Colorizer #bcdfff
	use("williamboman/mason.nvim") -- LSP/DAP/Linter package manager
	use("williamboman/mason-lspconfig.nvim") -- Mason <-> LSP bridge
	use("jose-elias-alvarez/null-ls.nvim") -- Use other sources as LSPs
	use("neovim/nvim-lspconfig") -- Default configs for LSPs
	use("hrsh7th/nvim-cmp") -- Completion engine
	use("hrsh7th/cmp-nvim-lsp") -- Completion for LSPs
	use("hrsh7th/cmp-buffer") -- Completion for buffers
	use("hrsh7th/cmp-path") -- Completion for filesystem paths
	use("hrsh7th/cmp-cmdline") -- Completion for command line
	use("L3MON4D3/LuaSnip") -- Snippet engine for completion
	use("terrortylor/nvim-comment") -- Commenting
	use("tpope/vim-fugitive") -- Git stuff
	use("windwp/windline.nvim") -- Statusline
	use("junegunn/fzf") -- Fuzzy search
	use("folke/trouble.nvim") -- Diagnostics
	use({
		"junegunn/fzf.vim",
		rtp = "/opt/hombrew/bin/fzf",
	})
end)

-- Colors & Icons
require("nvim-web-devicons").setup()
require("rose-pine").setup({})
require("wlsample.airline")
vim.cmd("colorscheme rose-pine")

-- Completion
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<Right>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping(function()
			cmp.complete()
		end, { "i", "s" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source w/ cmp for `/` search
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use command source w/ cmp for `:` commands
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "cmdline" },
	},
})

-- Give LSPs completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
require("lspconfig").jedi_language_server.setup({
	capabilities = capabilities,
})
require("lspconfig").gopls.setup({
	capabilities = capabilities,
})
require("lspconfig").tsserver.setup({
	capabilities = capabilities,
})
require("lspconfig").clangd.setup({
	capabilities = capabilities,
})

-- Other
require("colorizer").setup()
require("nvim_comment").setup({
	line_mapping = "<leader>cc",
	operator_mapping = "cc",
})
require("mason").setup()
require("nvim-treesitter.configs").setup({
	ensure_installed = "all", -- Install all treesitters
	ignore_install = { "phpdoc" }, -- phpdoc fails for some reason
	auto_install = true, -- Force install if not already
	highlight = { enable = true, disable = { "sql" } }, -- Use TS highlighting
})

-- Mappings
-- Quit
vim.api.nvim_set_keymap("n", "<C-q>", ":q!<CR>", {})
-- Show quick docs in hover
vim.api.nvim_set_keymap("n", "H", ":lua vim.lsp.buf.hover()<CR>", {})
-- Show errors in quickfix
vim.api.nvim_set_keymap("n", "K", ":Trouble<CR>", {})
-- Show references in quickfix
vim.api.nvim_set_keymap("n", "L", ":lua vim.lsp.buf.references()<CR>", {})
-- Go to definition
vim.api.nvim_set_keymap("n", "<C-]>", ":lua vim.lsp.buf.definition()<CR>", {})
-- Focus next window
vim.api.nvim_set_keymap("n", "W", "<C-W>w", {})
-- Trigger FZF
vim.api.nvim_set_keymap("n", "<C-f>", ":Rg<CR>", {})
-- Trigger Explorer
vim.api.nvim_set_keymap("n", "<C-e>", ":Explore<CR>", {})

-- Autocommands
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function()
		vim.lsp.buf.format()
	end,
})

require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua, -- Lua
		require("null-ls").builtins.formatting.black, -- Python
		-- require("null-ls").builtins.formatting.sqlfluff.with({ -- SQL
		-- 	extra_args = { "--dialect", "postgres" },
		-- }),
		require("null-ls").builtins.diagnostics.luacheck, -- Lua
		require("null-ls").builtins.diagnostics.flake8, -- Python
		require("null-ls").builtins.diagnostics.jsonlint, -- JSON
		-- require("null-ls").builtins.diagnostics.sqlfluff.with({ -- SQL
		-- 	extra_args = { "--dialect", "postgres" },
		-- }),
	},
})
