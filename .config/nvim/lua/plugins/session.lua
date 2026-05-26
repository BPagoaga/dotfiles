-- Session management via persistence.nvim
-- Integrates with snacks dashboard "s" key (section = "session")
-- Install: ~/.local/share/nvim/site/pack/session/start/persistence.nvim

local ok, persistence = pcall(require, "persistence")
if not ok then
	return
end

persistence.setup({
	dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
	need = 1, -- minimum number of file buffers needed to save a session
})

local map = vim.keymap.set
map("n", "<leader>qs", function() persistence.load() end, { desc = "Restore Session (cwd)" })
map("n", "<leader>qS", function() persistence.select() end, { desc = "Select Session" })
map("n", "<leader>ql", function() persistence.load({ last = true }) end, { desc = "Restore Last Session" })
map("n", "<leader>qd", function() persistence.stop() end, { desc = "Stop Persistence (don't save)" })
