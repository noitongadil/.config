local opt = vim.opt

opt.guicursor = ""
-- opt.gcr = "n-v-c-sm:block,i-ci-ve:ver25,t:block-TermCursor"
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

opt.foldenable = true
opt.foldlevel = 99
opt.foldmethod = "indent"
opt.foldcolumn = "0"
opt.foldopen = ""
opt.foldlevelstart = 0

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.api.nvim_set_hl(0, "NonText", { bg = "NONE" })
vim.api.nvim_set_hl(0, "Folded", { bg = "none", bold = true })
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })

vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "size"

opt.background = "dark"
opt.laststatus = 2

vim.pack.add({
	{ src = "https://github.com/vague-theme/vague.nvim" },
})

require("vague").setup({
    italic = false,
    transparent = true,
})

vim.cmd.colorscheme("vague")

local map = vim.keymap.set
vim.g.mapleader = " "

map("n", "<Leader>ex", "<cmd>Ex %:p:h<CR>")
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
