return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change a keymap
    keys[#keys + 1] = { "gvd", ":vsplit | lua vim.lsp.buf.definition()<CR>" }
    keys[#keys + 2] = { "ghd", ":split | lua vim.lsp.buf.definition()<CR>" }
  end,
  opts = {
    inlay_hints = {
      enabled = false,
      exclude = {}, -- filetypes for which you don't want to enable inlay hints
    },
    setup = {
      vtsls = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")

        lspconfig.vtsls.setup({
          root_dir = util.root_pattern(".git", "package-lock.json", "yarn.lock"),
        })
        return true
      end,
      eslint = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")

        lspconfig.eslint.setup({
          root_dir = util.root_pattern(".eslintrc.js", ".eslintrc.json"),
        })
        return true
      end,
      tailwindcss = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig.util")

        lspconfig.tailwindcss.setup({
          root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.ts"),
        })
        return true
      end,
    },
  },
}
