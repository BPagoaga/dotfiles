return {
  "olimorris/codecompanion.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  event = "VeryLazy",
  opts = {
    model = "copilot", -- utiliser GitHub Copilot
  },
  keys = {
    {
      "<leader>cc",
      function()
        require("codecompanion").chat()
      end,
      desc = "Chat Copilot",
    },
    {
      "<leader>ce",
      function()
        require("codecompanion").explain()
      end,
      desc = "Expliquer le code",
    },
    {
      "<leader>cr",
      function()
        require("codecompanion").review()
      end,
      desc = "Review du code",
    },
  },
}
