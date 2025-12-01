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
          ignored = false,
        })
      end,
      desc = "Find Files including hidden",
    },
    {
      "<leader>f.",
      function()
        local utils = require("lspconfig.util")
        local root = utils.root_pattern("package-lock.json", "yarn.lock", ".git")(".")
        Snacks.picker.files({
          cwd = root,
          hidden = true,
          ignored = true,
        })
      end,
      desc = "Find Files including ignored",
    },
    {
      "<leader> ",
      function()
        Snacks.picker.files({ cwd = vim.fn.expand("$HOME"), hidden = true })
      end,
      desc = "Find Files",
    },
    {
      "<leader>E",
      -- for monorepo
      function()
        local utils = require("lspconfig.util")
        local cwd = utils.root_pattern("package.json", "yarn.lock", ".git")(".")
        Snacks.notify(cwd)
        Snacks.explorer({
          layout = { preset = "default", preview = true },
          cwd = cwd,
          ignored = true,
          hidden = true,
          auto_close = true,
        })
      end,
      desc = "File explorer",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer({
          layout = { preset = "default", preview = true },
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
    styles = {
      dashboard = {
        border = "none",
      },
    },
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
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
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
        { pane = 1, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        function(opts)
          local lazy_stats = require("lazy.stats").stats()
          opts = opts or {}
          local ms = (math.floor(lazy_stats.startuptime * 100 + 0.5) / 100)
          -- local icon = opts.icon or "⚡ "
          local icon = opts.icon or " 🍒 "
          local infos = vim.fn.api_info()
          local version = infos.version.major .. "." .. infos.version.minor .. "." .. infos.version.patch
          Snacks.notify(version)

          return {
            section = "startup",
            opts = {
              align = "center",
              text = {
                { icon .. "Neovim loaded ", hl = "footer" },
                { lazy_stats.loaded .. "/" .. lazy_stats.count, hl = "special" },
                { " plugins in ", hl = "footer" },
                { ms .. "ms", hl = "special" },
                { " Version " .. version, hl = "footer" },
              },
            },
          }
        end,
        {
          pane = 2,
          icon = " ",
          desc = "Browse Repo",
          padding = 1,
          key = "b",
          action = function()
            Snacks.gitbrowse()
          end,
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
        },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local cmds = {
            {
              icon = " ",
              title = "Open PRs",
              cmd = "gh pr list -L 8",
              key = "P",
              action = function()
                vim.fn.jobstart("gh pr list --web", { detach = true })
              end,
            },
            {
              icon = " ",
              title = "Git Status",
              cmd = "hub status --short --branch --renames",
              ttl = 5 * 60,
            },
          }
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              pane = 2,
              section = "terminal",
              enabled = in_git,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            }, cmd)
          end, cmds)
        end,
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
