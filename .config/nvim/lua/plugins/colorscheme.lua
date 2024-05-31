-- return { {
--   "craftzdog/solarized-osaka.nvim",
--   lazy = true,
--   priority = 1000,
--   opts = {
--     lualine_bold = true,
--     transparent = true,
--     on_colors = function(colors)
--       colors.bg = "#2a2a40"
--       colors.fg = "#dfdfe2"
--       colors.bg_popup = "#0a0a23"
--       colors.bg_sidebar = "#1b1b32"
--       colors.bg_float = "#0a0a23"
--       colors.bg_statusline = "#1b1b32"
--
--       vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1b1b32" })
--       vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#1b1b32" })
--       vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#1b1b32" })
--       vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#1b1b32" })
--       vim.api.nvim_set_hl(0, "Folded", { fg = "#ffffff", bg = "#1b1b32" })
--       vim.api.nvim_set_hl(0, "IblIndent", { fg = "#1b1b32" })
--       vim.api.nvim_set_hl(0, "Visual", { bg = "#1b1b32", reverse = true })
--     end,
--   },
-- }, {
--   "LazyVim/LazyVim",
--   opts = {
--     colorscheme = "solarized-osaka",
--   },
-- } }
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    opts = {
      transparent_background = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
