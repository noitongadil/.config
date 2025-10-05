local opt = vim.opt
opt.guicursor = ""
opt.signcolumn = "yes"
opt.colorcolumn = "80"
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

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "size"

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.8" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/chentoast/marks.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

require("marks").setup({
	builtin_marks = { "<", ">", "^" },
	refresh_interval = 250,
	sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	excluded_filetypes = {},
	excluded_buftypes = {},
	mappings = {},
})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
	sync_install = true,
	auto_install = true,
	highlight = { enable = true },
	indent = { enable = false },
})

function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "ColorColumn", { fg = "#191724", bg = "#191724" })
	vim.api.nvim_set_hl(0, "Folded", { fg = "#6e6a86", bg = "none", bold = true })
	vim.cmd([[highlight! link TelescopeNormal   Normal]])
	-- vim.cmd([[highlight! link TelescopeBorder   FloatBorder]])

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
	-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000" })
	-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
end

-- colors
require("rose-pine").setup({
	variant = "moon",
	palette = {
		moon = {
			rose = "#ebbcba",
			gold = "#e0c797",
			foam = "#b0c6d5",
		},
	},

	enable = {
		terminal = true,
		legacy_highlights = false,
		migrations = true,
	},

	styles = {
		italic = false,
		transparency = false,
	},

	highlight_groups = {
		Comment = { fg = "muted" },
		StatusLine = { fg = "subtle", bg = "#191724" },
		Background = { bg = "#000000" },
		Normal = { bg = "#000000" },
		NormalNC = { bg = "#000000" },
		-- NormalFloat = { bg = "#000000" },
		FloatBorder = { bg = "#000000" },
	},
})
ColorMyPencils()

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

require("mason").setup({ ui = { border = "rounded" } })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		luau = { "stylua" },
		cpp = { "clang_format" },
		c = { "clang_format" },
		python = { "black" },
	},

	formatters = {
		clang_format = {
			command = "clang-format",
			args = { "--style=file", "-fallback-style=Google" },
		},
		black = {
			command = "black",
			args = { "-" },
			stdin = true,
		},
	},
})

vim.lsp.enable({
	"lua_ls",
	"clangd",
	"bash-language-server",
	"pyright",
	"stylua",
	"cmake-language-server",
})

require("blink.cmp").setup({
	signature = { enabled = true },
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})

local map = vim.keymap.set
vim.g.mapleader = " "

-- stylua: ignore start
map("n", "<Leader>ex", "<cmd>Ex %:p:h<CR>")
map("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>")
map("n", "<leader>zz", function() require("zen-mode").toggle() end)
map("n", "<leader>cf", function() require("conform").format({ lsp_format = false }) end)

local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fg", builtin.live_grep)
map("n", "<leader>fb", builtin.buffers)
map("n", "<leader>fh", builtin.help_tags)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "yanking highlight",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(e)
		local opts = { buffer = e.buf }
		map("n", "gd", function() vim.lsp.buf.definition() end, opts)
		map("n", "gD", function() vim.lsp.buf.declaration() end, opts)
		map("n", "gl", function() vim.diagnostic.open_float({ border = "rounded" }) end, opts)
		map("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)
		map("n", "<leader>gi", function() vim.lsp.buf.implementation() end, opts)
		map("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
		map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
		map("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
		map("n", "<leader>cr", function() vim.lsp.buf.rename() end, opts)
	end,
})
-- stylua: ignore end
