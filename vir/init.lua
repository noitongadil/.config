local opt = vim.opt

vim.cmd([[syntax off]])

-- opt.guicursor = ""
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
opt.laststatus = 2

vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

local function color_my_pencils()
	vim.api.nvim_set_hl(0, "ColorColumn", { fg = "#141415", bg = "#141415" })
	vim.api.nvim_set_hl(0, "Folded", { fg = "#6e6a86", bg = "none", bold = true })

	vim.api.nvim_set_hl(0, "StatusLine", { fg = "#cdcdcd", bg = "#141415", })
	vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#000000" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
end
color_my_pencils()

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

local function pack_clean()
	local active_plugins = {}
	local unused_plugins = {}

	for _, plugin in ipairs(vim.pack.get()) do
		active_plugins[plugin.spec.name] = plugin.active
	end

	for _, plugin in ipairs(vim.pack.get()) do
		if not active_plugins[plugin.spec.name] then
			table.insert(unused_plugins, plugin.spec.name)
		end
	end

	if #unused_plugins == 0 then
		print("No unused plugins.")
		return
	end

	local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
	end
end

local map = vim.keymap.set
vim.g.mapleader = " "

-- stylua: ignore start
map("n", "<Leader>ex", "<cmd>Ex %:p:h<CR>")
map("n", "<leader>pa", "<cmd>packadd present.nvim<CR>")
map("n", "<leader>pc", pack_clean)
map("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>")
map("n", "<leader>cf", function() require("conform").format({ lsp_format = false }) end)
map("n", "<leader>w", "<Cmd>:update<CR>")
map("n", "<leader>q", "<Cmd>:quit<CR>")
map("n", "<leader>Q", "<Cmd>:wqa<CR>")
map({ "n", "v", "x" }, ";", ":")
map({ "n", "v", "x" }, ":", ";")

-- harpoon replacement
map("n", "<leader>a", function() vim.cmd("argadd %") vim.cmd("argdedup") end)
map("n", "<leader>e", function() vim.cmd.args() end)
map("n", "<C-h>", function() vim.cmd("silent! 1argument") end)
map("n", "<C-j>", function() vim.cmd("silent! 2argument") end)
map("n", "<C-k>", function() vim.cmd("silent! 3argument") end)
map("n", "<C-l>", function() vim.cmd("silent! 4argument") end)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "yanking highlight",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- stylua: ignore end
