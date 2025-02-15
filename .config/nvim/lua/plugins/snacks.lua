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
      ";f",
      function()
        Snacks.picker.files()
      end,
      desc = "Find Files",
    },
    {
      ";:",
      function()
        Snacks.picker.search_history()
      end,
      desc = "Find Files",
    },
    {
      ";u",
      function()
        Snacks.picker.undo()
      end,
      desc = "Undo",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer({
          layout = { preset = "default", preview = true },
          auto_close = true,
        })
      end,
      desc = "File explorer",
    },
    {
      ";;",
      function()
        Snacks.picker.resume()
      end,
      desc = "Resume last picker",
    },
    {
      ";r",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      ";rb",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    {
      ";d",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      ";db",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Buffer Diagnostics",
    },
    {
      ";n",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Notification History",
    },
    {
      ";y",
      function()
        Snacks.picker.registers()
      end,
      desc = "Registers",
    },
    {
      ";s",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      ";b",
      function()
        Snacks.picker.buffers({
          current = false,
        })
      end,
      desc = "Find Buffers",
    },
    {
      "<leader>tt",
      function()
        Snacks.terminal.toggle()
      end,
      desc = "Open terminal",
    },
  },
  opts = {
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
    scroll = { enabled = false },
    terminal = {
      -- your terminal configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
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
