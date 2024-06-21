return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.presets.lsp_doc_border = true
    opts.presets.command_palette = false
    opts.presets.bottom_search = false
    -- opts.views = {
    --
    --   hover = {
    --     size = {
    --       width = "auto",
    --       height = "auto",
    --       max_height = 20,
    --       max_width = 120,
    --     },
    --     border = {
    --       style = "rounded",
    --       padding = { 0, 0 },
    --     },
    --     position = { row = 2, col = 2 },
    --     -- win_options = {
    --     --   wrap = true,
    --     --   linebreak = true,
    --     -- },
    --     -- win_options = {
    --     --   winhighlight = "Normal:Normal,FloatBoarder:FloatBoarder",
    --     -- },
    --   },
    -- }
  end,
}
