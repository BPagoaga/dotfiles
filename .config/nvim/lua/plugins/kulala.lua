return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>Fc", "<cmd>lua require('kulala').from_curl()<cr>", desc = "Paste from curl", ft = "http" },
  },
  config = function()
    require("kulala").setup({
      -- Optional: Set the default environment for the requests
      default_env = "staging",
      -- Optional: Set the default headers for the requests
      default_headers = {
        ["Content-Type"] = "application/json",
      },
    })
  end,
  opts = {
    default_env = "staging",
  },
}
