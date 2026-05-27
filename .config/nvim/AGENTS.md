# AGENTS.md — Knowledge Base for AI Agents

This document describes the structure, conventions, and invariants of this Neovim configuration for AI agents assisting with modifications.

## Config Identity

- **Location:** `~/.config/nvim/`
- **Runtime data:** `~/.local/share/nvim/`
- **Launch:** `nvim` (standard)
- **Neovim version:** 0.12+

## Plugin Management

**This config does NOT use lazy.nvim or packer.** Plugins are managed via Neovim's built-in package system (`:h packages`).

- Plugins are cloned into `~/.local/share/nvim/site/pack/<group>/start/<name>/`
- All plugins in `start/` load automatically at startup — there is no lazy-loading
- The install/update script is `install-plugins.sh` at the repo root
- To add a plugin: add a `clone` call to `install-plugins.sh` AND a `require("plugins.<name>")` in `init.lua`

### install-plugins.sh `clone` signature

```bash
clone "<pack-group>" "<github-user/repo>" "<directory-name>" ["<ref>"]
```

The optional 4th argument pins a release tag or commit SHA.

## File Structure

```
init.lua                    # Entry point — loads all modules in order
install-plugins.sh          # Plugin installer (git clone based)
lua/
  options.lua               # vim.opt settings
  keymaps.lua               # Global keymaps (loaded before plugins)
  autocmds.lua              # Autocommands
  plugins/
    colorscheme.lua         # tokyonight-storm (keywords = {}, no italic)
    lsp.lua                 # Native LSP (vim.lsp.config API, Nvim 0.12)
    treesitter.lua          # nvim-treesitter (new API) + textobjects
    completion.lua          # blink.cmp
    snacks.lua              # folke/snacks.nvim (explorer, pickers, dashboard, etc.)
    copilot.lua             # copilot.vim + CopilotChat.nvim
    dap.lua                 # nvim-dap + dapui + vscode-js-debug
    editor.lua              # autopairs, surround, Comment, gitsigns, which-key, mini
    ui.lua                  # lualine + render-markdown
    formatting.lua          # conform.nvim
    noice.lua               # noice.nvim
    yazi.lua                # yazi.nvim
    session.lua             # persistence.nvim
```

## Plugin Config Convention

Every file under `lua/plugins/` follows this pattern:

```lua
local ok, plugin = pcall(require, "plugin-name")
if not ok then return end

plugin.setup({ ... })

vim.keymap.set("n", "<leader>x", ..., { desc = "..." })
```

**Never** use lazy.nvim spec syntax (`opts = {}`, `keys = {}`, `lazy = false`, etc.) — it has no effect here.

## Keymap Conventions

- Leader: `Space`
- Global keymaps live in `lua/keymaps.lua` (loaded before plugins)
- Plugin keymaps are defined inside the plugin's config file
- which-key group prefixes are registered in `lua/plugins/editor.lua`

### Reserved leader prefixes

| Prefix | Group |
|--------|-------|
| `<leader>f` | Find/Files (snacks picker) |
| `<leader>g` | Git |
| `<leader>l` | LSP |
| `<leader>d` | Debug |
| `<leader>h` | Git Hunks (gitsigns) |
| `<leader>a` | AI/Copilot |
| `<leader>u` | UI/Notify |
| `<leader>o` | OpenCode |
| `<leader>w` | Window |
| `<leader>n` | Notifications |
| `<leader>e` | File explorer (snacks explorer) |
| `<leader>E` | Diagnostic float |

## LSP Setup

Uses Neovim 0.12 native `vim.lsp.config` / `vim.lsp.enable` API (not nvim-lspconfig). Servers are configured in `lua/plugins/lsp.lua`.

## Treesitter Setup

nvim-treesitter is pinned to a HEAD commit that contains a **full rewrite** incompatible with the old API. Key differences:

- **Setup:** `require('nvim-treesitter').setup({ install_dir = ... })` — only `install_dir` is accepted
- **Highlighting is NOT automatic.** It must be enabled per filetype via:
  ```lua
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typescript", "typescriptreact", ... },
    callback = function() vim.treesitter.start() end,
  })
  ```
- **No** `highlight`, `indent`, `ensure_installed`, `incremental_selection` keys in setup
- **Textobjects** use `require('nvim-treesitter-textobjects').setup(...)` — separate plugin, own API
- **Parser location:** `~/.local/share/nvim/site/parser/` (default `install_dir` = `stdpath('data')/site`)
- **Queries symlink:** nvim-treesitter stores queries under `runtime/queries/` but Neovim looks for `{plugin}/queries/`. `install-plugins.sh` creates a symlink `queries -> runtime/queries` automatically after cloning.

## Adding a New Plugin

1. Look up the latest release tag for the plugin on GitHub
2. Add `clone "<group>" "<user/repo>" "<name>" "<tag>"` to `install-plugins.sh` — **a pinned version is mandatory**
3. Create `lua/plugins/<name>.lua` using the `pcall(require, ...)` pattern
4. Add `require("plugins.<name>")` at the bottom of `init.lua`
5. Run `bash install-plugins.sh` to install

### Version pinning rules

- **Always** pin to a release tag (e.g. `"v1.2.3"`). Never omit the version argument.
- If the plugin has no release tags, pin to the current HEAD commit SHA (first 10 chars): `git ls-remote https://github.com/<user>/<repo> HEAD | cut -f1 | head -c 10`
- When updating a plugin, update the pinned version in `install-plugins.sh` at the same time.

## Removing a Plugin

1. Remove the `clone` line from `install-plugins.sh`
2. Remove the `require(...)` line from `init.lua`
3. Delete `lua/plugins/<name>.lua`
4. Remove the installed directory: `rm -rf ~/.local/share/nvim/site/pack/<group>/start/<name>`

## mini.nvim Usage

`mini.nvim` is a monorepo — the single `mini.nvim` package provides many modules:
- `mini.ai` — enhanced text objects (configured in `editor.lua`)
- `mini.icons` — icon provider

Do not add `mini.icons` or other mini modules as separate clone entries.
