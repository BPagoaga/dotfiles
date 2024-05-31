return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true,   -- This automatically runs `require("luarocks-nvim").setup()`
    enabled = false,
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    enabled = false,
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},   -- Loads default behaviour
          ["core.concealer"] = {},  -- Adds pretty icons to your documents
          ["core.completion"] = {}, -- enable completion
          ["core.dirman"] = {       -- Manages Neorg workspaces
            config = {
              workspaces = {
                work = "~/notes/work",
                home = "~/notes/home",
                sport = "~/notes/sport",
                todos = "~/notes/todos",
              },
              default_workspace = "todos",
            },
          },
        },
      })
    end,
  }
}
