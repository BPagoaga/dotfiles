-- live-preview.nvim: live browser preview for Markdown/HTML/AsciiDoc/SVG
--   ~/.local/share/nvim/site/pack/livepreview/start/live-preview.nvim

local ok, config = pcall(require, "livepreview.config")
if not ok then
  return
end

config.set({
  picker = "snacks",
})

local map = vim.keymap.set
map("n", "<leader>ps", "<cmd>LivePreview start<cr>", { desc = "Start preview" })
map("n", "<leader>pc", "<cmd>LivePreview close<cr>", { desc = "Close preview" })
map("n", "<leader>pp", "<cmd>LivePreview pick<cr>", { desc = "Pick file to preview" })
