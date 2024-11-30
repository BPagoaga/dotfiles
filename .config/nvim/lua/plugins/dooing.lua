return {
  "atiladefreitas/dooing",
  config = function()
    local notesPath = vim.fn.expand("$HOME/Nextcloud/Notes")
    require("dooing").setup({
      -- your custom config here (optional)
      save_path = notesPath .. "/dooing_todos.json",
    })
  end,
}
