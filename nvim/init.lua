local opt = vim.opt
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
opt.foldtext = ""
opt.foldcolumn = "0"
opt.fillchars:append({ fold = " " })
opt.foldopen = ""
opt.foldlevelstart = 99

vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "size"

vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/folke/zen-mode.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/jiaoshijie/undotree" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	-- { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

-- colors
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("ColorschemeLoad", { clear = true }),
	callback = function()
		require("vague").setup({
			colors = {
				bg = "#000000",
				inactiveBg = "#000000",
				fg = "#cdcdcd",
				floatBorder = "#ffffff",
				line = "#252530",
				comment = "#606079",
				builtin = "#b4d4cf",
				func = "#c48282",
				string = "#e8b589",
				number = "#e0a363",
				property = "#c3c3d5",
				constant = "#aeaed1",
				parameter = "#bb9dbd",
				visual = "#333738",
				error = "#d8647e",
				warning = "#f3be7c",
				hint = "#7e98e8",
				operator = "#90a0b5",
				keyword = "#6e94b2",
				type = "#9bb4bc",
				search = "#405065",
				plus = "#7fa563",
				delta = "#f3be7c",
			},
		})

		vim.cmd.colorscheme("vague")
		vim.cmd([[highlight! link WhichKeyBorder FloatBorder]])
		vim.cmd([[highlight! link FzfLuaBorder   FloatBorder]])

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
				StatusLine = { fg = "subtle", bg = "muted", blend = 15 },
				Background = { bg = "#000000" },
				Normal = { bg = "#000000" },
				NormalNC = { bg = "#000000" },
				NormalFloat = { bg = "#000000" },
				FloatBorder = { bg = "#000000" },
			},
		})
	end,
})

require("telescope").setup()
require("mason").setup({ ui = { border = "rounded" } })

-- formatter
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

-- zen
require("zen-mode").setup({
	window = {
		width = 100,
		options = {},
		border = "",
	},
})

-- lsp
vim.lsp.enable({
	"lua_ls",
	"clangd",
	"bash-language-server",
	"pyright",
	"stylua",
	"cmake-language-server",
})

-- autocomp
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
map("n", "<leader>u", vim.cmd.UndotreeToggle)
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
