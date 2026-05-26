return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false }, -- We’ll let Code Companion handle UI
      panel = { enabled = false },
    })
  end,
}
