-- copilot-lsp: native LSP-based Copilot with Next Edit Suggestions (NES)
-- Requires copilot-language-server on PATH (installed via copilot.vim or standalone)

local ok, copilot_lsp = pcall(require, "copilot-lsp")
if not ok then
	return
end

-- NES debounce (ms before suggestions are requested after cursor stops)
vim.g.copilot_nes_debounce = 500

-- Enable the copilot LSP server
vim.lsp.enable("copilot_ls")

-- Configure NES behavior
copilot_lsp.setup({
	nes = {
		move_count_threshold = 3,
	},
})

-- <Tab> in normal mode: apply NES suggestion, or fall back to <C-i>
vim.keymap.set("n", "<tab>", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local state = vim.b[bufnr].nes_state
	if state then
		local nes = require("copilot-lsp.nes")
		local _ = nes.walk_cursor_start_edit()
			or (nes.apply_pending_nes() and nes.walk_cursor_end_edit())
		return nil
	else
		return "<C-i>"
	end
end, { expr = true, desc = "Accept Copilot NES suggestion" })

-- <Esc> in normal mode: clear NES suggestion if visible
vim.keymap.set("n", "<esc>", function()
	require("copilot-lsp.nes").clear()
end, { desc = "Clear Copilot NES suggestion" })
