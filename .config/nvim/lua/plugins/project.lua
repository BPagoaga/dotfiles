-- Lua
return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      manual_mode = false,
      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "~/Nextcloud/Notes",
        "~/.config/nvim",
        "package-lock.json",
        "yarn.lock",
        "lazy-lock.json",
      },
      show_hidden = true,
      scope_chdir = "tab",
    })
  end,
}
