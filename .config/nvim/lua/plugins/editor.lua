-- Editor enhancement plugins:
--   ~/.local/share/nvim/site/pack/pairs/start/nvim-autopairs
--   ~/.local/share/nvim/site/pack/surround/start/nvim-surround
--   ~/.local/share/nvim/site/pack/comment/start/Comment.nvim
--   ~/.local/share/nvim/site/pack/git/start/gitsigns.nvim
--   ~/.local/share/nvim/site/pack/whichkey/start/which-key.nvim
--   ~/.local/share/nvim/site/pack/mini/start/mini.nvim

local map = vim.keymap.set

-- nvim-autopairs
local ok_pairs, autopairs = pcall(require, "nvim-autopairs")
if ok_pairs then
  autopairs.setup({
    check_ts = true,
    ts_config = {
      lua = { "string" },
      javascript = { "template_string" },
    },
    fast_wrap = {
      map = "<M-e>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = [=[[%'%"%>%]%)%}%,]]=],
      end_key = "$",
      keys = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma = true,
      highlight = "PmenuSel",
      highlight_grey = "LineNr",
    },
    disable_filetype = { "TelescopePrompt", "spectre_panel" },
  })
end

-- nvim-surround
local ok_surround, surround = pcall(require, "nvim-surround")
if ok_surround then
  surround.setup({})
end

-- Comment.nvim
local ok_comment, Comment = pcall(require, "Comment")
if ok_comment then
  Comment.setup({
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  })
end

-- gitsigns
local ok_gs, gitsigns = pcall(require, "gitsigns")
if ok_gs then
  gitsigns.setup({
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 300,
      virt_text_pos = "eol",
    },
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "󰍵" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "│" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local gmap = function(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        map(mode, l, r, opts)
      end
      gmap("n", "]g", function()
        gs.next_hunk()
      end, { desc = "Next Hunk" })
      gmap("n", "[g", function()
        gs.prev_hunk()
      end, { desc = "Prev Hunk" })
      gmap("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
      gmap("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
      gmap("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Stage Hunk" })
      gmap("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Reset Hunk" })
      gmap("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
      gmap("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
      gmap("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
      gmap("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, { desc = "Blame Line" })
      gmap("n", "<leader>hB", gs.toggle_current_line_blame, { desc = "Toggle Inline Blame" })
      gmap("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
      gmap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })
    end,
  })
end

-- which-key
local ok_wk, wk = pcall(require, "which-key")
if ok_wk then
  wk.setup({
    preset = "modern",
    delay = 500,
    icons = { mappings = true },
    spec = {
      -- Groups
      { "<leader>f",   group = "Find/Files" },
      { "<leader>g",   group = "Git" },
      { "<leader>go",  group = "Octo/GitHub" },
      { "<leader>l",   group = "LSP" },
      { "<leader>d",   group = "Debug" },
      { "<leader>h",   group = "Hunks" },
      { "<leader>a",   group = "AI/Copilot" },
      { "<leader>u",   group = "UI/Notify" },
      { "<leader>ai",  group = "OpenCode" },
      { "<leader>r",   group = "Refactor" },
      { "<leader>w",   group = "Window" },
      { "<leader>n",   group = "Notifications" },
      { "<leader>b",   group = "Buffers" },
      { "<leader>c",   group = "Code" },
      { "<leader>s",   group = "Search" },
      { "<leader>t",   group = "Terminal" },
      { "<leader>q",   group = "Session/Quit" },
      { "<leader>x",   group = "Trouble" },
      { "<leader>y",   group = "Yazi" },
      { "<leader>p",   group = "Preview" },
      -- Buffer
      { "<leader>bd",  desc = "Delete buffer" },
      -- Misc leader
      { "<leader>,",   desc = "Buffers" },
      { "<leader>:",   desc = "Command History" },
      { "<leader>o",   desc = "New line below" },
      { "<leader>O",   desc = "New line above" },
      { "<leader>wq",  desc = "Save and quit" },
      -- Code / LSP
      { "<leader>ca",  desc = "Code action" },
      { "<leader>cd",  desc = "Line diagnostics" },
      { "<leader>cl",  desc = "LSP Info" },
      { "<leader>cw",  desc = "Open yazi (cwd)" },
      { "<leader>rn",  desc = "Rename symbol" },
      { "<leader>sr",  desc = "Search and replace" },
      { "<leader>ds",  desc = "Document symbols" },
      { "<leader>ws",  desc = "Workspace symbols" },
      { "<leader>ih",  desc = "Toggle inlay hints" },
      -- LSP navigation (buffer-local)
      { "gd",          desc = "LSP: Go to definition" },
      { "gD",          desc = "LSP: Go to declaration" },
      { "gr",          desc = "LSP: Go to references" },
      { "gI",          desc = "LSP: Go to implementation" },
      { "gt",          desc = "LSP: Go to type definition" },
      { "gvd",         desc = "LSP: Go to definition (vsplit)" },
      { "ghd",         desc = "LSP: Go to definition (split)" },
      { "K",           desc = "LSP: Hover documentation" },
      -- Diagnostics
      { "<leader>E",   desc = "Diagnostic float" },
      { "<leader>dq",  desc = "Diagnostics to loclist" },
      { "[d",          desc = "Previous diagnostic" },
      { "]d",          desc = "Next diagnostic" },
      -- Git
      { "]g",          desc = "Next hunk" },
      { "[g",          desc = "Prev hunk" },
      -- AI / Copilot
      { "<leader>aa",  desc = "Toggle Copilot Chat" },
      { "<leader>ax",  desc = "Clear Copilot Chat" },
      { "<leader>aq",  desc = "Quick Copilot Chat" },
      { "<leader>ap",  desc = "Copilot Prompts" },
      { "<leader>aic", desc = "Open OpenCode AI" },
      -- Debug (DAP)
      { "<leader>db",  desc = "Toggle Breakpoint" },
      { "<leader>dB",  desc = "Conditional Breakpoint" },
      { "<leader>dl",  desc = "Log Point" },
      { "<leader>dc",  desc = "Continue" },
      { "<leader>di",  desc = "Step Into" },
      { "<leader>do",  desc = "Step Over" },
      { "<leader>dO",  desc = "Step Out" },
      { "<leader>dC",  desc = "Run to Cursor" },
      { "<leader>dr",  desc = "Open REPL" },
      { "<leader>dR",  desc = "Run Last" },
      { "<leader>dh",  desc = "Eval",                          mode = { "n", "v" } },
      { "<leader>du",  desc = "Toggle DAP UI" },
      -- Trouble
      { "<leader>xx",  desc = "Diagnostics" },
      { "<leader>xX",  desc = "Buffer Diagnostics" },
      { "<leader>xs",  desc = "Symbols" },
      { "<leader>xl",  desc = "LSP definitions/references" },
      { "<leader>xL",  desc = "Location List" },
      { "<leader>xQ",  desc = "Quickfix List" },
      -- Octo / GitHub
      { "<leader>goi", desc = "Issues" },
      { "<leader>goI", desc = "Create Issue" },
      { "<leader>gop", desc = "Pull Requests" },
      { "<leader>goP", desc = "Create PR" },
      { "<leader>gor", desc = "Start Review" },
      { "<leader>goa", desc = "Actions" },
      -- Yazi
      { "<leader>yz",  desc = "Open yazi (current file)" },
      -- Live Preview
      { "<leader>ps",  desc = "Start preview" },
      { "<leader>pc",  desc = "Close preview" },
      { "<leader>pp",  desc = "Pick file to preview" },
      -- Session
      { "<leader>qs",  desc = "Restore Session (cwd)" },
      { "<leader>qS",  desc = "Select Session" },
      { "<leader>ql",  desc = "Restore Last Session" },
      { "<leader>qd",  desc = "Stop Persistence" },
      -- Notifications
      { "<leader>nn",  desc = "Notification History" },
      { "<leader>nd",  desc = "Dismiss Notifications" },
      -- UI
      { "<leader>uC",  desc = "Colorschemes" },
      -- Terminal
      { "<leader>to",  desc = "Open terminal" },
      { "<leader>tt",  desc = "Toggle terminal" },
      -- Refactor
      { "<leader>re",  desc = "Extract function",              mode = "x" },
      { "<leader>rf",  desc = "Extract function to file",      mode = "x" },
      { "<leader>rv",  desc = "Extract variable",              mode = "x" },
      { "<leader>ri",  desc = "Inline variable",               mode = { "n", "x" } },
      { "<leader>rI",  desc = "Inline function" },
      { "<leader>rb",  desc = "Extract block" },
      { "<leader>rB",  desc = "Extract block to file" },
      { "<leader>rp",  desc = "Print var (debug)",             mode = { "n", "x" } },
      { "<leader>rP",  desc = "Print func (debug)" },
      { "<leader>rc",  desc = "Clean up debug prints" },
    },
  })
end

-- mini.ai
local ok_mini_ai, mini_ai = pcall(require, "mini.ai")
if ok_mini_ai then
  mini_ai.setup({ n_lines = 500 })
end

-- todo-comments.nvim
local ok_todo_comments, todo_comments = pcall(require, "todo-comments")
if ok_todo_comments then
  todo_comments.setup({})
end


-- ddoing.nvim
local ok_dooing, dooing = pcall(require, "dooing")
if ok_dooing then
  local notesPath = vim.fn.expand("$HOME/Nextcloud/Notes")
  local savePath = notesPath .. "/dooing_todos.json"
  dooing.setup({
    -- your custom config here (optional)
    save_path = savePath,
  })
end
