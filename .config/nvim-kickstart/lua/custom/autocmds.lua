-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
-- General Settings
local general = augroup('General', { clear = true })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Turn off paste mode when leaving insert
autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste',
})

autocmd({ 'FocusLost', 'BufLeave', 'BufWinLeave', 'InsertLeave' }, {
  -- nested = true, -- for format on save
  callback = function()
    if vim.bo.filetype ~= '' and vim.bo.buftype == '' then
      vim.cmd 'silent! w'
    end
  end,
  group = general,
  desc = 'Auto Save',
})

autocmd('FileType', {
  pattern = 'qf',
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set('n', '<C-n>', '<cmd>cn | wincmd p<CR>', opts)
    vim.keymap.set('n', '<C-p>', '<cmd>cN | wincmd p<CR>', opts)
  end,
})

autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    require('conform').format { bufnr = args.buf }
  end,
})

autocmd('FileType', {
  pattern = 'dap-float',
  command = 'nnoremap <buffer><silent> q <cmd>close!<CR>',
})

vim.filetype.add {
  pattern = {
    ['.*%.component%.html'] = 'angular.html', -- Sets the filetype to `angular.html` if it matches the pattern
  },
}

autocmd('FileType', {
  pattern = 'angular.html',
  callback = function()
    vim.treesitter.language.register('angular', 'angular.html') -- Register the filetype with treesitter for the `angular` language/parser
  end,
})
