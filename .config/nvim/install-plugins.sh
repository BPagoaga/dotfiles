#!/usr/bin/env bash
# Install all plugins via vim-pack (built-in Neovim package manager)
# Plugins go to: ~/.local/share/nvim/site/pack/<pack-name>/start/<plugin>

PACK_DIR="$HOME/.local/share/nvim/site/pack"

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
clone "themes"    "folke/tokyonight.nvim"                       "tokyonight.nvim"                   "cdc07ac784"

# Treesitter
clone "treesitter" "nvim-treesitter/nvim-treesitter"            "nvim-treesitter"                   "4916d6592e"
clone "treesitter" "nvim-treesitter/nvim-treesitter-textobjects" "nvim-treesitter-textobjects"       "851e865342"

# Completion
clone "completion" "Saghen/blink.cmp"                           "blink.cmp"                         "v1.10.2"
if [ ! -f "$PACK_DIR/completion/start/blink.cmp/target/release/libblink_cmp_fuzzy.dylib" ]; then
  echo "Building blink.cmp native fuzzy library..."
  LUAJIT_PREFIX="$(brew --prefix luajit 2>/dev/null || echo /opt/homebrew/opt/luajit)"
  export RUSTFLAGS="-L $LUAJIT_PREFIX/lib -l luajit-5.1"
  if cargo build --release --manifest-path "$PACK_DIR/completion/start/blink.cmp/Cargo.toml"; then
    echo "blink.cmp built successfully."
  else
    echo "WARNING: blink.cmp build failed — ensure Rust/cargo and luajit (brew install luajit) are installed."
  fi
  unset RUSTFLAGS
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

# Editor
clone "editor"       "folke/todo-comments.nvim"                 "todo-comments"                      "v1.5.0"
clone "editor"       "atiladefreitas/dooing"                    "dooing"                             "v2.10.0"

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
clone "ui"        "folke/trouble.nvim"                          "trouble"                           "bd67efe408d4816e25e8491cc5ad4088e708a69a"
clone "pairs"     "windwp/nvim-autopairs"                       "nvim-autopairs"                    "0.10.0"
clone "surround"  "kylechui/nvim-surround"                      "nvim-surround"                     "v4.0.5"
clone "comment"   "numToStr/Comment.nvim"                       "Comment.nvim"                      "v0.8.0"
clone "comment"   "JoosepAlviste/nvim-ts-context-commentstring" "nvim-ts-context-commentstring"     "6141a40173"
clone "git"       "lewis6991/gitsigns.nvim"                     "gitsigns.nvim"                     "v2.1.0"
clone "whichkey"  "folke/which-key.nvim"                        "which-key.nvim"                    "v3.17.0"
clone "mini"      "echasnovski/mini.nvim"                       "mini.nvim"                         "v0.17.0"
clone "markdown"  "MeanderingProgrammer/render-markdown.nvim"   "render-markdown.nvim"              "v8.12.0"

# GitHub integration
clone "github"    "pwntester/octo.nvim"                         "octo.nvim"                         "b9a73e167f"

# Session management
clone "session"   "folke/persistence.nvim"                         "persistence.nvim"                  "v3.1.0"

# UI enhancements
clone "noice"     "folke/noice.nvim"                            "noice.nvim"                        "v4.10.0"
clone "noice"     "MunifTanjim/nui.nvim"                        "nui.nvim"                          "0.4.0"

# Yazi file manager
clone "yazi"      "nvim-lua/plenary.nvim"                       "plenary.nvim"                      "v0.1.4"
clone "yazi"      "mikavilpas/yazi.nvim"                        "yazi.nvim"                         "v13.1.6"

# Refactoring
clone "refactor"  "lewis6991/async.nvim"                         "async.nvim"                        "7a1d7d4993"
clone "refactor"  "ThePrimeagen/refactoring.nvim"               "refactoring.nvim"                  "624c01e817"

# Java (nvim-java + dependencies)
clone "java"      "neovim/nvim-lspconfig"                        "nvim-lspconfig"                    "v1.6.0"
clone "java"      "nvim-java/lua-async-await"                    "lua-async-await"                   "v0.0.7"
clone "java"      "nvim-java/nvim-java-core"                     "nvim-java-core"                    "v1.3.2"
clone "java"      "nvim-java/nvim-java-test"                     "nvim-java-test"                    "v0.5.0"
clone "java"      "nvim-java/nvim-java-dap"                      "nvim-java-dap"                     "v0.3.0"
clone "java"      "nvim-java/nvim-java"                          "nvim-java"                         "v2.3.0"

# nvim-treesitter (pinned commit) stores queries under runtime/queries/ not queries/
# Neovim looks for queries at {plugin}/queries/ so we symlink to make them discoverable
TS_DIR="$PACK_DIR/treesitter/start/nvim-treesitter"
if [ -d "$TS_DIR/runtime/queries" ] && [ ! -L "$TS_DIR/queries" ]; then
  ln -sf "$TS_DIR/runtime/queries" "$TS_DIR/queries"
  echo "Created queries symlink for nvim-treesitter."
fi

echo ""
echo "Done! Open Neovim and run :TSUpdate to install parsers."
echo "Run :Copilot setup for GitHub Copilot authentication."
