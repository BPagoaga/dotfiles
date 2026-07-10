-- Install: ~/.local/share/nvim/site/pack/grugfar/start/grug-far.nvim
-- Requires ripgrep on PATH.

local ok, grug_far = pcall(require, "grug-far")
if not ok then
	return
end

grug_far.setup()

vim.keymap.set("n", "<leader>sr", function() grug_far.open() end, { desc = "Search and replace" })
