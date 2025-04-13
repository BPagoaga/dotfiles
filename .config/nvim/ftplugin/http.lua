local keymap = vim.api.nvim_buf_set_keymap

local options = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

local cmd = function(cmd)
  return "<cmd>lua require('kulala')." .. cmd .. "()<CR>"
end

-- execute request
keymap(0, "n", "<CR>", cmd("run"), options("Execute request"))

-- create request from curl
keymap(0, "n", "<leader>ci", cmd("from_curl"), options("Paste curl from clipboard as http request"))
