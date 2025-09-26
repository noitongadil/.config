vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim" },
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	-- { src = "https://github.com/Saghen/blink.cmp" },
	-- { src = "https://github.com/ibhagwan/fzf-lua" },
	-- { src = "https://github.com/nvim-tree/nvim-web-devicons" },
	-- { src = "https://github.com/lewis6991/gitsigns.nvim" },
	-- { src = "https://github.com/folke/which-key.nvim" },
	-- { src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/folke/zen-mode.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/jiaoshijie/undotree" },
	{ src = "https://github.com/stevearc/conform.nvim" },
})

function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)

	vim.cmd([[highlight! link WhichKeyBorder FloatBorder]])
	vim.cmd([[highlight! link FzfLuaBorder   FloatBorder]])

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
	-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000" })
	-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
end

require("rose-pine").setup({
	variant = "moon",
	palette = {
		moon = {
			rose = "#ebbcba",
			gold = "#e0c797",
			foam = "#b0c6d5",
			-- love = "#b4637a",
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

require("vague").setup({
	colors = {
		bg = "#000000",
		inactiveBg = "#000000",
		fg = "#cdcdcd",
		floatBorder = "#000000",
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

ColorMyPencils("vague")

vim.cmd([[set completeopt+=menuone,noselect,popup]])

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

-- require("which-key").setup({
-- 	win = {
-- 		border = "rounded",
-- 	},
-- })

-- require("gitsigns").setup({
-- 	signcolumn = true,
-- 	signs = {
-- 		add = { text = "+" },
-- 		change = { text = "~" },
-- 		delete = { text = "_" },
-- 		topdelete = { text = "‾" },
-- 		changedelete = { text = "~" },
-- 	},
-- })

require("mason").setup({
	ui = { border = "rounded" },
})

vim.lsp.enable({
	"lua_ls",
	"clangd",
	"bash-language-server",
	"pyright",
	"stylua",
	"cmake-language-server",
})

vim.cmd([[set completeopt+=menuone,noselect,popup]])

-- vim.lsp.config("lua_ls", {
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				version = "LuaJIT",
-- 			},
-- 			diagnostics = {
-- 				globals = {
-- 					"vim",
-- 					"require",
-- 				},
-- 			},
-- 			workspace = {
-- 				library = vim.api.nvim_get_runtime_file("", true),
-- 			},
-- 			telemetry = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- })

-- require("blink.cmp").setup({
-- 	signature = { enabled = true },
-- 	completion = {
-- 		documentation = { auto_show = true, auto_show_delay_ms = 500 },
-- 		menu = {
-- 			auto_show = true,
-- 			draw = {
-- 				treesitter = { "lsp" },
-- 				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
-- 			},
-- 		},
-- 	},
-- 	fuzzy = { implementation = "prefer_rust_with_warning" },
-- })

-- require("fzf-lua").setup({
-- 	winopts = { backdrop = 85 },
-- })

function Treesitter_setup()
	local configs = require("nvim-treesitter.configs")

	configs.setup({
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"cpp",
			"rust",
		},
		auto_install = true,
		sync_install = false,
		highlight = { enable = true },
		indent = { enable = false },

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<Enter>", -- set to `false` to disable one of the mappings
				node_incremental = "<Enter>",
				scope_incremental = false,
				node_decremental = "<Backspace>",
			},
		},
	})
end
Treesitter_setup()
