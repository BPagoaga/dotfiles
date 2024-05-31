return {
  "goolord/alpha-nvim",
  opts = function(_, dashboard)
    -- local buttonProjects = dashboard.button("p", " " .. " Projects", ":Telescope projects <CR>")
    -- buttonProjects.opts.hl = "AlphaButtons"
    -- buttonProjects.opts.hl_shortcut = "AlphaShortcut"
    -- table.insert(dashboard.section.buttons.val, 4, buttonProjects)

    local buttonFileExplorer =
      dashboard.button("b", " " .. " File Browser", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
    buttonFileExplorer.opts.hl = "AlphaButtons"
    buttonFileExplorer.opts.hl_shortcut = "AlphaShortcut"
    table.insert(dashboard.section.buttons.val, 5, buttonFileExplorer)
  end,
}
