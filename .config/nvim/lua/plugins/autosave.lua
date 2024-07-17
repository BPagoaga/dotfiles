return {
  "okuuva/auto-save.nvim",
  cmd = "ASToggle", -- optional for lazy loading on command
  event = { "InsertLeave", "TextChanged", "FocusLost" }, -- optional for lazy loading on trigger events
  opts = {
    -- trigger_events = { "InsertLeave", "FocusLost", "WinLeave", "TabLeave", "BufLeave" },
    trigger_events = { -- See :h events
      immediate_save = { "InsertLeave", "FocusLost" }, -- vim events that trigger an immediate save
      defer_save = { "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
      cancel_defered_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
    },
    debounce_delay = 500,
    execution_message = {
      enabled = false,
    },
  },
}
