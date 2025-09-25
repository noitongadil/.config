local opt = vim.opt
opt.guicursor = ""
opt.colorcolumn = "80"
opt.signcolumn = "yes:1"
opt.termguicolors = true
opt.ignorecase = true

opt.swapfile = false

opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true

opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.list = true
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.cursorline = false
opt.scrolloff = 8

opt.inccommand = "split"
opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
opt.undofile = true
opt.clipboard = "unnamed"
opt.completeopt = { "menuone", "popup", "noinsert" }

vim.cmd.filetype("plugin indent on")

vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "size"

opt.foldenable = true
opt.foldlevel = 99
opt.foldmethod = "indent"
opt.foldtext = ""
opt.foldcolumn = "0"
opt.fillchars:append({ fold = " " })
opt.foldopen = ""
opt.foldlevelstart = 99
