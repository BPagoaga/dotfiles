#!/usr/bin/env bash
# Install all plugins via vim-pack (built-in Neovim package manager)
# Plugins go to: ~/.local/share/nvim-copilot/site/pack/<pack-name>/start/<plugin>

PACK_DIR="$HOME/.local/share/nvim-copilot/site/pack"

# clone "<pack>" "<user/repo>" "<name>" ["<ref>"]
# Skips install if the plugin is already at the pinned ref (tracked via .pin file).
clone() {
  local pack="$1" repo="$2" name="$3" ref="${4:-}"
  local dest="$PACK_DIR/$pack/start/$name"
  local pin_file="$dest/.pin"

  if [ -d "$dest" ]; then
    local current_pin
    current_pin=$(cat "$pin_file" 2>/dev/null)
    if [ "$current_pin" = "$ref" ]; then
      echo "$name is up to date ($ref)."
      return
    fi
    echo "Updating $name to $ref (was: ${current_pin:-unpinned})..."
    rm -rf "$dest"
  else
    echo "Installing $name ($ref)..."
  fi

  if [ -n "$ref" ]; then
    git clone --depth 1 --branch "$ref" "https://github.com/$repo" "$dest" 2>/dev/null \
      || { git clone "https://github.com/$repo" "$dest" && git -C "$dest" checkout "$ref" --quiet; }
  else
    git clone --depth 1 "https://github.com/$repo" "$dest"
  fi

  echo "$ref" > "$pin_file"
}

# Theme
clone "themes"    "folke/tokyonight.nvim"                       "tokyonight.nvim"                   "v4.14.1"

# Treesitter
clone "treesitter" "nvim-treesitter/nvim-treesitter"            "nvim-treesitter"                   "v0.10.0"
clone "treesitter" "nvim-treesitter/nvim-treesitter-textobjects" "nvim-treesitter-textobjects"       "851e865342"

# Completion
clone "completion" "Saghen/blink.cmp"                           "blink.cmp"                         "v1.10.2"
if [ ! -f "$PACK_DIR/completion/start/blink.cmp/target/release/libblink_cmp_fuzzy.dylib" ]; then
  echo "Building blink.cmp native fuzzy library..."
  cargo build --release --manifest-path "$PACK_DIR/completion/start/blink.cmp/Cargo.toml" --quiet \
    && echo "blink.cmp built successfully." \
    || echo "WARNING: blink.cmp build failed — ensure Rust/cargo is installed."
else
  echo "blink.cmp native library already built, skipping."
fi

# Snacks (pickers, dashboard, lazygit, scratch)
clone "snacks"    "folke/snacks.nvim"                           "snacks.nvim"                       "v2.31.0"

# Copilot
clone "copilot"   "github/copilot.vim"                          "copilot.vim"                       "v1.59.0"
clone "copilot"   "CopilotC-Nvim/CopilotChat.nvim"              "CopilotChat.nvim"                  "v4.7.4"
clone "copilot"   "copilotlsp-nvim/copilot-lsp"                 "copilot-lsp"                       "1b6d827359"
clone "copilot"   "fang2hou/blink-copilot"                      "blink-copilot"                     "v1.4.1"

# DAP
clone "dap"       "mfussenegger/nvim-dap"                       "nvim-dap"                          "0.10.0"
clone "dap"       "rcarriga/nvim-dap-ui"                        "nvim-dap-ui"                       "v4.0.0"
clone "dap"       "nvim-neotest/nvim-nio"                       "nvim-nio"                          "v1.10.1"
clone "dap"       "theHamsta/nvim-dap-virtual-text"             "nvim-dap-virtual-text"             "fbdb48c2ed"
clone "dap"       "mxsdev/nvim-dap-vscode-js"                  "nvim-dap-vscode-js"                "v1.1.0"

# Formatting
clone "format"    "stevearc/conform.nvim"                       "conform.nvim"                      "v9.1.0"

# UI & utilities
clone "ui"        "nvim-lualine/lualine.nvim"                   "lualine.nvim"                      "131a558e13"
clone "ui"        "nvim-tree/nvim-web-devicons"                 "nvim-web-devicons"                 "v0.100"
clone "pairs"     "windwp/nvim-autopairs"                       "nvim-autopairs"                    "0.10.0"
clone "surround"  "kylechui/nvim-surround"                      "nvim-surround"                     "v4.0.5"
clone "comment"   "numToStr/Comment.nvim"                       "Comment.nvim"                      "v0.8.0"
clone "git"       "lewis6991/gitsigns.nvim"                     "gitsigns.nvim"                     "v2.1.0"
clone "whichkey"  "folke/which-key.nvim"                        "which-key.nvim"                    "v3.17.0"
clone "mini"      "echasnovski/mini.nvim"                       "mini.nvim"                         "v0.17.0"
clone "markdown"  "MeanderingProgrammer/render-markdown.nvim"   "render-markdown.nvim"              "v8.12.0"

# UI enhancements
clone "noice"     "folke/noice.nvim"                            "noice.nvim"                        "v4.10.0"
clone "noice"     "MunifTanjim/nui.nvim"                        "nui.nvim"                          "0.4.0"

# Yazi file manager
clone "yazi"      "mikavilpas/yazi.nvim"                        "yazi.nvim"                         "v13.1.6"

echo ""
echo "Done! Open Neovim and run :TSUpdate to install parsers."
echo "Run :Copilot setup for GitHub Copilot authentication."
