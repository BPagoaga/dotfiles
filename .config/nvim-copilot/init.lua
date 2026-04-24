-- =============================================================================
-- init.lua — Neovim 0.12.0 Configuration
-- Plugin management: vim-pack (built-in :h packages)
-- Focus: Frontend Web Dev (TS/ESLint/Tailwind/Prettier), Java, Markdown
-- =============================================================================

-- Leaders must be set before any plugin or keymap module is loaded
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core
require("options")
require("keymaps")
require("autocmds")

-- Plugins
require("plugins.colorscheme")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.completion")
require("plugins.snacks")
require("plugins.copilot")
require("plugins.dap")
require("plugins.editor")
require("plugins.ui")
require("plugins.formatting")
