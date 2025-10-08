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
	{ src = "https://github.com/chentoast/marks.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/folke/zen-mode.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.8" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
})

require("marks").setup({
	builtin_marks = { "<", ">", "^" },
	refresh_interval = 250,
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	excluded_filetypes = {},
	excluded_buftypes = {},
	mappings = {},
})

require("zen-mode").setup({
	window = {
		width = 100,
		options = {},
		border = "",
	},
})

require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},

	defaults = {
		color_devicons = true,
		sorting_strategy = "ascending",
		-- borderchars = { "-", "|", "-", "|", "-", "+", "+", "|" },
		borderchars = { "", "", "", "", "", "", "", "" },
		path_displays = "smart",
		layout_strategy = "horizontal",
		layout_config = {
			height = 100,
			width = 400,
			prompt_position = "top",
			preview_cutoff = 40,
		},
	},
})
require("telescope").load_extension("fzf")

function ColorMyPencils()
	vim.api.nvim_set_hl(0, "ColorColumn", { fg = "grey", bg = "grey" })
	vim.api.nvim_set_hl(0, "Folded", { fg = "#6e6a86", bg = "none", bold = true })
	vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
end
ColorMyPencils()

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
map("n", "<leader>cf", function() require("conform").format({ lsp_format = false }) end)
map("n", "<leader>zz", function() require("zen-mode").toggle() end)

local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fg", builtin.live_grep)
map("n", "<leader><leader>", builtin.buffers)
map("n", "<leader>fh", builtin.help_tags)
map("n", "<leader>fb", builtin.builtin)
map("n", "<leader>fm", builtin.man_pages)
map("n", "<leader>fc", function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "yanking highlight",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- stylua: ignore end
