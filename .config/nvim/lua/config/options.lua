-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.opt.cursorcolumn = true
vim.opt.colorcolumn = "120"
vim.opt.scrolloff = 8 -- Lines of context
-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- kuala
vim.filetype.add({
  extension = {
    ["http"] = "http",
  },
})

-- grug-far
vim.g.maplocalleader = ","
