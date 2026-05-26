return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
      exclude = {}, -- filetypes for which you don't want to enable inlay hints
    },
    servers = {
      ["*"] = {
        keys = {
          { "gvd", ":vsplit | lua vim.lsp.buf.definition()<CR>", has = "definition" },
          { "ghd", ":split | lua vim.lsp.buf.definition()<CR>", has = "definition" },
        },
      },
    },

    -- setup = {
    --   vtsls = function()
    --     local lspconfig = require("lspconfig")
    --     local util = require("lspconfig.util")
    --
    --     lspconfig.vtsls.setup({
    --       root_dir = util.root_pattern(".git", "package-lock.json", "yarn.lock"),
    --     })
    --     return true
    --   end,
    --   eslint = function()
    --     local lspconfig = require("lspconfig")
    --     local util = require("lspconfig.util")
    --
    --     lspconfig.eslint.setup({
    --       root_dir = util.root_pattern(".eslintrc.js", ".eslintrc.json"),
    --     })
    --     return true
    --   end,
    --   tailwindcss = function()
    --     local lspconfig = require("lspconfig")
    --     local util = require("lspconfig.util")
    --
    --     lspconfig.tailwindcss.setup({
    --       root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.ts"),
    --     })
    --     return true
    --   end,
    -- },
  },
}
