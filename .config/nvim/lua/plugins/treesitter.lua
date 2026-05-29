-- Install: ~/.local/share/nvim/site/pack/treesitter/start/nvim-treesitter
-- Rewritten nvim-treesitter (Neovim 0.12+): highlighting is NOT auto-enabled.
-- We must call vim.treesitter.start() ourselves via FileType autocmd.

local ok, treesitter = pcall(require, "nvim-treesitter")
if not ok then
	return
end

treesitter.setup({
	-- install_dir defaults to stdpath('data') .. '/site', already in rtp
})

-- Install parsers for languages we care about (no-op if already installed)
treesitter.install({
	"bash", "css", "html", "java", "javascript", "jsdoc",
	"json", "lua", "luadoc", "markdown", "markdown_inline",
	"regex", "scss", "tsx", "typescript", "vim", "vimdoc", "xml", "yaml",
})

-- Enable treesitter highlighting and folding per filetype
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"typescript", "typescriptreact",
		"javascript", "javascriptreact",
		"css", "scss", "html", "json", "yaml",
		"lua", "vim", "bash", "markdown", "java", "xml",
	},
	callback = function()
		vim.treesitter.start()
		vim.wo[0][0].foldmethod = "expr"
		vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
})

-- Textobjects
local ok_tx, textobjects = pcall(require, "nvim-treesitter-textobjects")
if ok_tx then
	textobjects.setup({
		select = {
			lookahead = true,
		},
	})

	-- Select
	local select = require("nvim-treesitter-textobjects.select")
	local move = require("nvim-treesitter-textobjects.move")

	local sel = function(q) return function() select.select_textobject(q, "textobjects") end end
	vim.keymap.set({ "x", "o" }, "af", sel("@function.outer"))
	vim.keymap.set({ "x", "o" }, "if", sel("@function.inner"))
	vim.keymap.set({ "x", "o" }, "ac", sel("@class.outer"))
	vim.keymap.set({ "x", "o" }, "ic", sel("@class.inner"))
	vim.keymap.set({ "x", "o" }, "aa", sel("@parameter.outer"))
	vim.keymap.set({ "x", "o" }, "ia", sel("@parameter.inner"))
	vim.keymap.set({ "x", "o" }, "ab", sel("@block.outer"))
	vim.keymap.set({ "x", "o" }, "ib", sel("@block.inner"))

	-- Move
	local function mv(dir, start, q)
		return function() move["goto_" .. dir .. "_" .. start](q, "textobjects") end
	end
	vim.keymap.set("n", "]f", mv("next", "start", "@function.outer"))
	vim.keymap.set("n", "]c", mv("next", "start", "@class.outer"))
	vim.keymap.set("n", "[f", mv("previous", "start", "@function.outer"))
	vim.keymap.set("n", "[c", mv("previous", "start", "@class.outer"))
end
