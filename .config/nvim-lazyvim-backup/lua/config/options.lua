-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
--- Enable the option to require a Prettier config file

-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = true
vim.g.root_spec = { { ".git", "lua" }, "cwd", "lsp" }

vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.wrap = true
vim.opt.backup = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.directory = os.getenv("HOME") .. "/.vim/swap"
vim.opt.backupdir = os.getenv("HOME") .. "/.vim/backup"
vim.opt.undofile = true
vim.opt.undolevels = 100
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.updatetime = 100
vim.opt.spell = true
vim.opt.spelllang = { "en_us", "fr" }
vim.opt.colorcolumn = "120"
vim.opt.swapfile = false
-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- kulala
vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})

-- grug-far
vim.g.maplocalleader = "!"

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)
-- Enable break indent
vim.o.breakindent = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "context:12",
  "algorithm:histogram",
  "linematch:200",
  "indent-heuristic",
}
vim.opt.winborder = "rounded"
