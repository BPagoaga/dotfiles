-- Yazi: terminal file manager integration
--   ~/.local/share/nvim-copilot/site/pack/yazi/start/yazi.nvim

local ok, yazi = pcall(require, "yazi")
if not ok then
	return
end

yazi.setup({
	open_for_directories = false,
	use_ya_for_events_reading = true,
	use_yazi_client_id_flag = true,
	keymaps = {
		show_help = "<f1>",
	},
})

local map = vim.keymap.set
map("n", "<leader>yz", "<cmd>Yazi<cr>", { desc = "Open yazi at current file" })
map("n", "<leader>cw", "<cmd>Yazi cwd<cr>", { desc = "Open yazi in working directory" })
map("n", "<C-Up>", "<cmd>Yazi toggle<cr>", { desc = "Resume last yazi session" })
