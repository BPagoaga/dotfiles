-- Install: ~/.local/share/nvim/site/pack/snacks/start/snacks.nvim

local ok, Snacks = pcall(require, "snacks")
if not ok then
  return
end

local map = vim.keymap.set

Snacks.setup({
  styles = {
    dashboard = { border = "none" },
  },

  statuscolumn = {
    left = { "mark", "sign" },
    right = { "fold", "git" },
    folds = { open = false, git_hl = false },
    git = { patterns = { "GitSign", "MiniDiffSign" } },
    refresh = 50,
  },

  scroll = {
    animate = {
      duration = { step = 15, total = 80 },
      easing = "inOutCubic",
    },
    animate_repeat = {
      delay = 100,
      duration = { step = 5, total = 50 },
      easing = "linear",
    },
    filter = function(buf)
      return vim.g.snacks_scroll ~= false
          and vim.b[buf].snacks_scroll ~= false
          and vim.bo[buf].buftype ~= "terminal"
    end,
  },

  dashboard = {
    preset = {
      pick = nil,
      keys = {
        { icon = " ", key = "f", desc = "Find File",       action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "n", desc = "New File",        action = ":ene | startinsert" },
        { icon = " ", key = "g", desc = "Find Text",       action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = " ", key = "r", desc = "Recent Files",    action = ":lua Snacks.picker.recent({ filter = { cwd = true } })" },
        { icon = " ", key = "s", desc = "Restore Session", action = ":lua require('persistence').load()" },
      },
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
      { icon = " ",        title = "Keymaps", section = "keys",       indent = 2,               padding = 1 },
      { pane = 1,          icon = " ",        title = "Recent Files", section = "recent_files", indent = 2, padding = 1, cwd = true },
      { pane = 1,          icon = " ",        title = "Projects",     section = "projects",     indent = 2, padding = 1 },
      (function()
        local icon = " 🍒 "
        local v = vim.version()
        local version = v.major .. "." .. v.minor .. "." .. v.patch
        return {
          align = "center",
          text = {
            { icon .. "Neovim ", hl = "footer" },
            { "v" .. version,    hl = "special" },
          },
        }
      end)(),
      {
        align = "center",
        text = {
          { "⚡ Loaded in ", hl = "footer" },
          { math.floor((vim.uv.hrtime() - vim.g._start_ns) / 1e6 + 0.5) .. "ms", hl = "special" },
        },
      },
      {
        pane = 2,
        icon = " ",
        desc = "Browse Repo",
        padding = 1,
        key = "b",
        action = function() Snacks.gitbrowse() end,
        enabled = function() return Snacks.git.get_root() ~= nil end,
      },
      function()
        local in_git = Snacks.git.get_root() ~= nil
        local cmds = {
          { icon = " ", title = "Open PRs",   cmd = "gh pr list -L 8",                       key = "P" },
          { icon = " ", title = "Git Status", cmd = "hub status --short --branch --renames", ttl = 5 * 60 },
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

  terminal = {},
  lazygit = {},

  notifier = {
    enabled = true,
    timeout = 3000,
  },

  explorer = { enabled = true },

  picker = {
    sources = {
      explorer = {
        layout = { preset = "default", preview = true },
        auto_close = true,
        jump = { close = true },
      },
    },
  },
})

vim.opt.statuscolumn = [[%!v:lua.Snacks.statuscolumn()]]

-- ============================================================================
-- Scratch
-- ============================================================================
map("n", "<localleader>sn", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
map("n", "<localleader>st", function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })

-- ============================================================================
-- File explorer
-- ============================================================================
map("n", "<leader>e", function()
  Snacks.explorer({
    layout = { preset = "default", preview = true },
    ignored = true,
    hidden = true,
    auto_close = true,
  })
end, { desc = "File explorer" })

map("n", "<leader>E", function()
  local root = vim.fs.root(0, { "package-lock.json", "yarn.lock", ".git" })
  Snacks.explorer({
    layout = { preset = "default", preview = true },
    cwd = root,
    ignored = true,
    hidden = true,
    auto_close = true,
  })
end, { desc = "File explorer (root)" })

-- ============================================================================
-- Pickers — Files
-- ============================================================================
map("n", "<leader>ff", function()
  local root = vim.fs.root(0, { "package-lock.json", "yarn.lock", ".git" })
  Snacks.picker.files({ cwd = root, hidden = true, ignored = false })
end, { desc = "Find Files (root)" })

map("n", "<leader>f.", function()
  local root = vim.fs.root(0, { "package-lock.json", "yarn.lock", ".git" })
  Snacks.picker.files({ cwd = root, hidden = true, ignored = true })
end, { desc = "Find Files including ignored" })

map("n", "<leader> ", function()
  Snacks.picker.files({ cwd = vim.fn.expand("$HOME"), hidden = true })
end, { desc = "Find Files (home)" })

map("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Files (git)" })
map("n", "<leader>fr", function() Snacks.picker.recent({ filter = { cwd = true } }) end, { desc = "Recent Files (cwd)" })
map("n", "<leader>fR", function() Snacks.picker.recent() end, { desc = "Recent Files (all)" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, { desc = "Buffers (all)" })
map("n", "<leader>fp", function()
  Snacks.picker.projects({
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "package-lock.json", "Makefile", "yarn.lock" },
  })
end, { desc = "Projects" })

-- ============================================================================
-- Pickers — Search / Grep
-- ============================================================================
map("n", "<leader>sg", function()
  local root = vim.fs.root(0, { "package-lock.json", "yarn.lock", ".git" })
  Snacks.picker.grep({ cwd = root })
end, { desc = "Grep (root)" })

map("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
map("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" })
map("n", "<leader>ss", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
map("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume Picker" })
map("n", "<leader>;", function() Snacks.picker.resume() end, { desc = "Resume Picker" })

-- ============================================================================
-- Pickers — Vim / Editor
-- ============================================================================
map("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
map("n", "<leader>s/", function() Snacks.picker.search_history() end, { desc = "Search History" })
map("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
map("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
map("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
map("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
map("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
map("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
map("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
map("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
map("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
map("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
map("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
map("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undotree" })
map("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
map("n", "<leader>nn", function() Snacks.picker.notifications() end, { desc = "Notification History" })
map("n", "<leader>nd", function() Snacks.notifier.hide() end, { desc = "Dismiss Notifications" })

-- ============================================================================
-- Pickers — LSP
-- ============================================================================
map("n", "<leader>cl", function() Snacks.picker.lsp_config() end, { desc = "LSP Info" })
map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols (document)" })
map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })

-- ============================================================================
-- Pickers — Git
-- ============================================================================
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
map("n", "<leader>gG", function() Snacks.lazygit({ cwd = vim.fn.getcwd() }) end, { desc = "Lazygit (cwd)" })
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
map("n", "<leader>gL", function() Snacks.picker.git_log_file() end, { desc = "Git Log (file)" })
map("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
map("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
map("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
map("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (hunks)" })
map("n", "<leader>gD", function() Snacks.picker.git_diff({ base = "origin", group = true }) end,
  { desc = "Git Diff (origin)" })
map("n", "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (open)" })
map("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues (all)" })
map("n", "<leader>gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub PRs (open)" })
map("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, { desc = "GitHub PRs (all)" })

-- ============================================================================
-- Terminal
-- ============================================================================
map("n", "<leader>to", function() Snacks.terminal.open() end, { desc = "Open terminal" })
map("n", "<leader>tt", function() Snacks.terminal.toggle() end, { desc = "Toggle terminal" })
map({ "n", "t" }, "<C-/>", function() Snacks.terminal.toggle() end, { desc = "Toggle terminal" })

-- ============================================================================
-- OpenCode AI
-- ============================================================================
map("n", "<leader>aic", function()
  Snacks.terminal("opencode", {
    cwd = vim.fn.getcwd(),
    esc_esc = false,
    ctrl_hjkl = false,
    win = {
      position = "right",
      width = 0.4,
    },
  })
end, { desc = "Open OpenCode AI" })
