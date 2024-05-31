return {
  "stevearc/conform.nvim",
  event = {"BufReadPre", "BufNewFile"},
  config = function()
    local conform = require("conform")
    
    conform.setup({
      formatters_by_ft = {
        javascript = {"prettierd"},
        typescript = {"prettierd"},
        javascriptreact = {"prettierd"},
        typescriptreact = {"prettierd"},
        html = {"prettierd"},
        scss = {"prettierd"},
        css = {"prettierd"},
        json = {"prettierd"},
        yaml = {"prettierd"},
        lua = {"stylelua"}
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500
      }
    })
  end
}
