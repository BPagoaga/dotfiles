return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = function()
    local util = require("lspconfig.util")
    return {
      root_dir = util.root_pattern(".git", "package-lock.json", "yarn.lock"),
      settings = {
        expose_as_code_action = "all",
      },
    }
  end,
}
