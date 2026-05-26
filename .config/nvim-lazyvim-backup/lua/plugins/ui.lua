return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.presets.lsp_doc_border = true
    opts.presets.command_palette = false
    opts.presets.bottom_search = false
  end,
}
