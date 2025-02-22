return {
  "nanozuki/tabby.nvim",
  config = function()
    require("tabby").setup({
      preset = "tab_only",
    })
  end,
}
