local ok, octo = pcall(require, "octo")
if not ok then return end

octo.setup({
  picker = "snacks",
  enable_builtin = true,
})

local map = vim.keymap.set

map("n", "<leader>goi", "<cmd>Octo issue list<cr>",        { desc = "Issues" })
map("n", "<leader>goI", "<cmd>Octo issue create<cr>",      { desc = "Create Issue" })
map("n", "<leader>gop", "<cmd>Octo pr list<cr>",           { desc = "Pull Requests" })
map("n", "<leader>goP", "<cmd>Octo pr create<cr>",         { desc = "Create PR" })
map("n", "<leader>gor", "<cmd>Octo review start<cr>",      { desc = "Start Review" })
map("n", "<leader>goa", "<cmd>Octo actions<cr>",           { desc = "Actions" })
