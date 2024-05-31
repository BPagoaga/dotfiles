-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- send deleted char to blackhole register
keymap.set("n", "x", '"_x')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")
--
-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- surround with curly braces
keymap.set("v", "<leader>{", "c{<Esc>pa}<Esc>")
-- surround with brackets
keymap.set("v", "<leader>[", "c[<Esc>pa]<Esc>")
-- surround with parentheses
keymap.set("v", "<leader>(", "c(<Esc>pa)<Esc>")
-- surround with double quotes
keymap.set("v", '<leader>"', 'c"<Esc>pa"<Esc>')
-- surround with simple quotes
keymap.set("v", "<leader>'", "c'<Esc>pa'<Esc>")

-- move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep whatever is in the register when pasting / deleting
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- rewatch the primeagen video on vim motions cuz that shit is useless
vim.keymap.set("n", "J", "mzJ`z")

-- center cursor on the screen when scrolling up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- when searching, keep the highlight in the center of the screen
vim.keymap.set("n", "n", "nzzzv")
-- same but backward
vim.keymap.set("n", "N", "Nzzzv")

-- go to next and previous error and center it
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- go to next and previous location and center it
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Add line under the cursor and stay in normal mode
keymap.set("n", "<leader>o", "o<Esc>", opts)
-- Add line above the cursor and stay in normal mode
keymap.set("n", "<leader>O", "O<Esc>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move between windows
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
