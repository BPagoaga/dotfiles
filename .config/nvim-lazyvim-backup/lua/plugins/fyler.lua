return {
  "A7Lavinraj/fyler.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fyler").setup({
      icon_provider = "nvim_web_devicons",
      integrations = {
        winpick = {
          provider = "snacks",
          opts = {},
        },
      },
    })
  end,
  opts = {
    source = {
      explorer = {
        layout = { preset = "default", preview = true },
        auto_close = true,
      },
    },
  },
}
