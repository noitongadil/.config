local opt = vim.opt

vim.cmd([[syntax off]])

opt.guicursor = ""
opt.colorcolumn = "80"
opt.signcolumn = "yes"
opt.termguicolors = true
opt.ignorecase = true

opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true

opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.cursorline = false
opt.scrolloff = 8

opt.inccommand = "split"
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.swapfile = false
opt.clipboard = "unnamed"
opt.completeopt = { "menuone", "popup", "noinsert" }

opt.foldenable = true
opt.foldlevel = 99
opt.foldmethod = "indent"
opt.foldcolumn = "0"
opt.foldopen = ""
opt.foldlevelstart = 0

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "size"

opt.background = "dark"

vim.pack.add({
	{ src = "https://github.com/folke/zen-mode.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
})

function ColorMyPencils()
	vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
end

ColorMyPencils()

-- zen
require("zen-mode").setup({
	window = {
		width = 100,
		options = {},
		border = "",
	},
})

-- formatter
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		cpp = { "clang_format" },
		c = { "clang_format" },
	},

	formatters = {
		clang_format = {
			command = "clang-format",
			args = { "--style=file", "-fallback-style=Google" },
		},
	},
})

local map = vim.keymap.set
vim.g.mapleader = " "

-- stylua: ignore start
map("n", "<Leader>ex", "<cmd>Ex %:p:h<CR>")
map("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>")
map("n", "<leader>zz", function() require("zen-mode").toggle() end)
map("n", "<leader>cf", function() require("conform").format({ lsp_format = false }) end)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "yanking highlight",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- stylua: ignore end
