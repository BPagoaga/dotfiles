# nvim-copilot

A Neovim 0.12 configuration for frontend web development (TypeScript, Tailwind, Prettier), Java, and Markdown, with GitHub Copilot integration.

**Plugin manager:** built-in vim-pack (`:h packages`) — no lazy.nvim, no packer.

## Requirements

- Neovim >= 0.12
- Git
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal
- Node.js (for Copilot and vscode-js-debug)
- `prettier` and `google-java-format` on your `$PATH` (for formatting)

## Installation

```bash
# 1. Clone the config
git clone <repo-url> ~/.config/nvim-copilot

# 2. Install all plugins
cd ~/.config/nvim-copilot
bash install-plugins.sh

# 3. Open Neovim with this config
NVIM_APPNAME=nvim-copilot nvim

# 4. Install Treesitter parsers (inside Neovim)
:TSUpdate

# 5. Authenticate GitHub Copilot (inside Neovim)
:Copilot setup
```

To use this config as your default, set `NVIM_APPNAME=nvim-copilot` in your shell profile, or symlink `~/.config/nvim` to this directory.

## Key Shortcuts

`<leader>` is `Space`.

### File Explorer (fyler.nvim)

| Key | Action |
|-----|--------|
| `<leader>e` | Open file explorer (sidebar) |
| `<CR>` | Open file / expand directory |
| `<BS>` | Collapse node |
| `q` | Close explorer |
| `\|` | Open in vertical split |
| `-` | Open in horizontal split |
| `<C-t>` | Open in new tab |
| `^` | Go to parent directory |
| `=` | Go to cwd |
| `#` | Collapse all |

### Finding Files & Search (snacks.nvim)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent files |

### LSP

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | References |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>E` | Show diagnostic float |

### Git (gitsigns + lazygit)

| Key | Action |
|-----|--------|
| `<leader>gg` | Open lazygit |
| `]g` / `[g` | Next / previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff this |

### AI / Copilot

| Key | Action |
|-----|--------|
| `<leader>aa` | Open CopilotChat |
| `Tab` | Accept Copilot suggestion |

### Debug (DAP)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>du` | Toggle DAP UI |

### Editor

| Key | Action |
|-----|--------|
| `<C-s>` | Save file |
| `<leader>q` | Quit |
| `<S-l>` / `<S-h>` | Next / previous buffer |
| `<leader>bd` | Delete buffer |
| `gcc` | Toggle line comment |
| `<C-d>` / `<C-u>` | Scroll down / up (centered) |

## Plugin List

| Plugin | Purpose |
|--------|---------|
| tokyonight.nvim | Colorscheme |
| nvim-treesitter | Syntax / textobjects |
| blink.cmp | Completion |
| snacks.nvim | Picker, dashboard, lazygit, terminal |
| copilot.vim + CopilotChat.nvim | GitHub Copilot |
| fyler.nvim | File explorer |
| nvim-dap + dap-ui | Debugger |
| conform.nvim | Formatting |
| lualine.nvim | Statusline |
| gitsigns.nvim | Git decorations |
| which-key.nvim | Keymap hints |
| mini.nvim | AI textobjects, icons |
| nvim-autopairs | Auto bracket pairs |
| nvim-surround | Surround motions |
| Comment.nvim | Commenting |
| render-markdown.nvim | Markdown rendering |
