return {
  "folke/snacks.nvim",
  keys = {
    {
      -- scratch
      "<localleader>sn",
      function()
        Snacks.scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<localleader>st",
      function()
        Snacks.scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
    -- picker
    {
      "<leader>ff",
      function()
        local utils = require("lspconfig.util")
        local root = utils.root_pattern("package-lock.json", "yarn.lock", ".git")(".")
        Snacks.picker.files({
          cwd = root,
          hidden = true,
        })
      end,
      desc = "Find Files",
    },
    {
      "<leader> ",
      function()
        Snacks.picker.files({ cwd = vim.fn.expand("$HOME"), hidden = true })
      end,
      desc = "Find Files",
    },
    {
      "<leader>e",
      function()
        local utils = require("lspconfig.util")
        local root = utils.root_pattern("package-lock.json", "yarn.lock", ".git")(".")
        Snacks.explorer({
          layout = { preset = "default", preview = true },
          cwd = root,
          ignored = true,
          hidden = true,
          auto_close = true,
        })
      end,
      desc = "File explorer",
    },
    {
      "<leader>;",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume last picker",
    },
    {
      "<leader>sg",
      function()
        local utils = require("lspconfig.util")
        local package = utils.root_pattern("package.json")(".")
        Snacks.picker.grep({ cwd = package })
      end,
      desc = "Grep in current package",
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects({
          patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "package-lock.json", "Makefile", "yarn.lock" },
        })
      end,
    },
    {
      "<leader>to",
      function()
        Snacks.terminal.open()
      end,
      desc = "Open terminal",
    },
    {
      "<leader>tt",
      function()
        Snacks.terminal.toggle()
      end,
      desc = "Toggle terminal",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Open lazygit",
    },
  },
  opts = {
    ---@class snacks.scroll.Config
    ---@field animate snacks.animate.Config|{}
    ---@field animate_repeat snacks.animate.Config|{}|{delay:number}
    scroll = {
      animate = {
        duration = { step = 15, total = 80 },
        easing = "inOutCubic",
      },
      -- faster animation when repeating scroll after delay
      animate_repeat = {
        delay = 100, -- delay in ms before using the repeat animation
        duration = { step = 5, total = 50 },
        easing = "linear",
      },
      -- what buffers to animate
      filter = function(buf)
        return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
      end,
    },
    dashboard = {
      -- These settings are used by some built-in sections
      preset = {
        -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
        ---@type fun(cmd:string, opts:table)|nil
        pick = nil,
        -- Used by the `keys` section to show keymaps.
        -- Set your curstom keymaps here.
        -- When using a function, the `items` argument are the default keymaps.
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        -- Used by the `header` section
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
        {
          pane = 3,
          section = "terminal",
          cmd = "nerdfetch",
          padding = 1,
        },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = vim.fn.isdirectory(".git") == 1,
          cmd = "hub status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
      },
    },
    scratch = {
      root = vim.fn.expand("$HOME/Nextcloud/Notes") .. "/scratch",
    },
    terminal = {
      -- your terminal configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    lazygit = {},
    picker = {
      source = {
        "buffers",
        "diagnostics",
        "diagnostics_buffer",
        explorer = {
          layout = { preset = "default", preview = true },
          auto_close = true,
        },
        "files",
        "grep",
        "grep_buffers",
        "lsp_config",
        "lsp_declarations",
        "lsp_definitions",
        "lsp_implementations",
        "lsp_references",
        "lsp_symbols",
        "lsp_type_definitions",
        "marks",
        "notifications",
        "registers",
        "search_history",
        "smart",
      },
    },
  },
}
