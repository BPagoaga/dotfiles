-- Noice: replaces UI for messages, cmdline, and popupmenu
--   ~/.local/share/nvim-copilot/site/pack/noice/start/noice.nvim
-- Dependencies: nui.nvim (required)

local ok, noice = pcall(require, "noice")
if not ok then
	return
end

noice.setup({
	presets = {
		lsp_doc_border = true,
		command_palette = false,
		bottom_search = false,
	},
})
