local augroup = vim.api.nvim_create_augroup
local MyGroup = augroup("MyGroup", {})

vim.keymap.set("n", "<leader>ps", "<cmd>lua vim.pack.update()<CR>")

vim.keymap.set("n", "gl", function()
	vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "open diagnostic in float" })

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		lsp_format = false,
	})
end, { desc = "format current file" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "yanking highlight",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded", max_height = 25, max_width = 120 })
end)

local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
	group = MyGroup,
	callback = function()
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, { desc = "goto defintion" })

		vim.keymap.set("n", "gD", function()
			vim.lsp.buf.declaration()
		end, { desc = "goto declaration" })

		vim.keymap.set("n", "<leader>gi", function()
			vim.lsp.buf.implementation()
		end, { desc = "goto implementation" })

		-- vim.keymap.set("n", "<leader>ws", function()
		-- 	vim.lsp.buf.workspace_symbol()
		-- end, { desc = "workspace symbols" })

		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, { desc = "code action" })

		vim.keymap.set("n", "<leader>vr", function()
			vim.lsp.buf.references()
		end, { desc = "goto refs" })

		vim.keymap.set("n", "<leader>cr", function()
			vim.lsp.buf.rename()
		end, { desc = "rename" })

		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, { desc = "signature help" })
	end,
})

local map = function(mode, lhs, fn, desc)
	vim.keymap.set(mode, lhs, fn, { desc = desc, silent = true })
end

map("n", "<leader>D", function()
	require("fzf-lua").lsp_typedefs()
end, "type def")

map("n", "<leader>ds", function()
	require("fzf-lua").lsp_document_symbols()
end, "doc symbols")

map("n", "<leader>ws", function()
	require("fzf-lua").lsp_live_workspace_symbols()
end, "workspace symbols")

map("n", "<leader>ff", function()
	require("fzf-lua").files()
end, "find files in project dir")

map("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, "grep project dir")

map("n", "<leader>fc", function()
	require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
end, "find in neovim config")

map("n", "<leader>fh", function()
	require("fzf-lua").helptags()
end, "find help")

map("n", "<leader>fk", function()
	require("fzf-lua").keymaps()
end, "find keymaps")

map("n", "<leader>fb", function()
	require("fzf-lua").builtin()
end, "find builtin FZF")

map("n", "<leader>fw", function()
	require("fzf-lua").grep_cword()
end, "find current word")

map("n", "<leader>fW", function()
	require("fzf-lua").grep_cWORD()
end, "find current WORD")

map("n", "<leader>fd", function()
	require("fzf-lua").diagnostics_document()
end, "find diagnostics")

map("n", "<leader>fr", function()
	require("fzf-lua").resume()
end, "resume last picker")

map("n", "<leader>fo", function()
	require("fzf-lua").oldfiles()
end, "find old files")

map("n", "<leader><leader>", function()
	require("fzf-lua").buffers()
end, "find existing buffers")

map("n", "<leader>/", function()
	require("fzf-lua").lgrep_curbuf()
end, "live grep current buffer")

vim.keymap.set("n", "<leader>zz", function()
	require("zen-mode").setup({
		window = {
			width = 100,
			options = {},
			border = "",
		},
	})
	require("zen-mode").toggle()
	vim.wo.wrap = false
	vim.wo.number = true
	vim.wo.rnu = true
end, { desc = "toggle zen" })

map("n", "<Leader>ex", "<cmd>Ex %:p:h<CR>")

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "toggle undotree" })
