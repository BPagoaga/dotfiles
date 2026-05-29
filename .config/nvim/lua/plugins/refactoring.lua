-- Install: ~/.local/share/nvim/site/pack/refactor/start/refactoring.nvim
-- Dependency: ~/.local/share/nvim/site/pack/refactor/start/async.nvim
-- All refactoring functions are operators (expr = true) — they return strings like "g@".

local ok, refactoring = pcall(require, "refactoring")
if not ok then
	return
end

refactoring.setup()

local map = vim.keymap.set

-- Extract (operator-pending: works on motion/textobject after the keymap)
map({ "n", "x" }, "<leader>re", function() return refactoring.extract_func() end,           { desc = "Extract function",        expr = true })
map({ "n", "x" }, "<leader>rf", function() return refactoring.extract_func_to_file() end,   { desc = "Extract function to file", expr = true })
map({ "n", "x" }, "<leader>rv", function() return refactoring.extract_var() end,            { desc = "Extract variable",         expr = true })

-- Inline (cursor-based, no motion needed)
map({ "n", "x" }, "<leader>ri", function() return refactoring.inline_var() end,             { desc = "Inline variable",          expr = true })
map("n",          "<leader>rI", function() return refactoring.inline_func() end,            { desc = "Inline function",          expr = true })

-- Block extract
map("n",          "<leader>rb", function() return refactoring.extract_block() end,          { desc = "Extract block",            expr = true })
map("n",          "<leader>rB", function() return refactoring.extract_block_to_file() end,  { desc = "Extract block to file",    expr = true })

-- Debug print var — appends "iw" so it acts on the word under cursor in normal mode
local debug = require("refactoring.debug")
map("n", "<leader>rp", function()
	return debug.print_var({ output_location = "below" }) .. "iw"
end, { desc = "Print var (debug)", expr = true })
map("x", "<leader>rp", function()
	return debug.print_var({ output_location = "below" })
end, { desc = "Print var (debug)", expr = true })

-- Debug cleanup — acts on the whole file with "ag" (all of buffer via textobject)
map({ "n", "x" }, "<leader>rc", function()
	return debug.cleanup({ restore_view = true })
end, { desc = "Clean up debug prints", expr = true, remap = true })
