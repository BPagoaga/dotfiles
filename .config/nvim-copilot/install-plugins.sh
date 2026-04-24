#!/usr/bin/env bash
# Install all plugins via vim-pack (built-in Neovim package manager)
# Plugins go to: ~/.local/share/nvim/site/pack/<pack-name>/start/<plugin>

PACK_DIR="$HOME/.local/share/nvim-copilot/site/pack"

clone() {
  local pack="$1" repo="$2" name="$3"
  local dest="$PACK_DIR/$pack/start/$name"
  if [ ! -d "$dest" ]; then
    echo "Installing $name..."
    git clone --depth 1 "https://github.com/$repo" "$dest"
  else
    echo "Updating $name..."
    git -C "$dest" pull --ff-only
  fi
}

# Theme
clone "themes" "folke/tokyonight.nvim" "tokyonight.nvim"

# Treesitter
clone "treesitter" "nvim-treesitter/nvim-treesitter" "nvim-treesitter"
clone "treesitter" "nvim-treesitter/nvim-treesitter-textobjects" "nvim-treesitter-textobjects"

# Completion
clone "completion" "Saghen/blink.cmp" "blink.cmp"

# Snacks (pickers, dashboard, lazygit, scratch)
clone "snacks" "folke/snacks.nvim" "snacks.nvim"

# Copilot
clone "copilot" "github/copilot.vim" "copilot.vim"
clone "copilot" "CopilotC-Nvim/CopilotChat.nvim" "CopilotChat.nvim"

# DAP
clone "dap" "mfussenegger/nvim-dap" "nvim-dap"
clone "dap" "rcarriga/nvim-dap-ui" "nvim-dap-ui"
clone "dap" "nvim-neotest/nvim-nio" "nvim-nio" # dap-ui dep
clone "dap" "theHamsta/nvim-dap-virtual-text" "nvim-dap-virtual-text"
clone "dap" "mxsdev/nvim-dap-vscode-js" "nvim-dap-vscode-js"

# Formatting
clone "format" "stevearc/conform.nvim" "conform.nvim"

# UI & utilities
clone "ui" "nvim-lualine/lualine.nvim" "lualine.nvim"
clone "ui" "nvim-tree/nvim-web-devicons" "nvim-web-devicons"
clone "pairs" "windwp/nvim-autopairs" "nvim-autopairs"
clone "surround" "kylechui/nvim-surround" "nvim-surround"
clone "comment" "numToStr/Comment.nvim" "Comment.nvim"
clone "git" "lewis6991/gitsigns.nvim" "gitsigns.nvim"
clone "whichkey" "folke/which-key.nvim" "which-key.nvim"
clone "mini" "echasnovski/mini.nvim" "mini.nvim"
clone "markdown" "MeanderingProgrammer/render-markdown.nvim" "render-markdown.nvim"

echo ""
echo "Done! Open Neovim and run :TSUpdate to install parsers."
echo "Run :Copilot setup for GitHub Copilot authentication."
