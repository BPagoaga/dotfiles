local map = vim.keymap.set

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "sh", "<C-w>h", { desc = "Move to left window" })
map("n", "sj", "<C-w>j", { desc = "Move to lower window" })
map("n", "sk", "<C-w>k", { desc = "Move to upper window" })
map("n", "sl", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
map("n", "bo", ":%bdelete|edit#|bdelete#<CR>", { desc = "Delete all other buffers" })

-- New line without entering insert mode
map("n", "<leader>o", "o<Esc>", { desc = "New line below" })
map("n", "<leader>O", "O<Esc>", { desc = "New line above" })

-- Clear search highlight
map("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlight" })

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered when scrolling (only if cursor actually moved)
map("n", "<C-d>", function()
	local before = vim.fn.line(".")
	vim.cmd("normal! \x04") -- <C-d>
	if vim.fn.line(".") ~= before then vim.cmd("normal! zz") end
end)
map("n", "<C-u>", function()
	local before = vim.fn.line(".")
	vim.cmd("normal! \x15") -- <C-u>
	if vim.fn.line(".") ~= before then vim.cmd("normal! zz") end
end)
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Indentation in visual mode keeps selection
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Better paste (don't overwrite register on visual paste)
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Save with Ctrl+S
map({ "n", "i", "v" }, "<C-s>", "<Esc>:w<CR>", { desc = "Save file" })

-- Quit
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" })

-- Diagnostic keymaps (0.12 style)
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>E", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
