-- Install: ~/.local/share/nvim/site/pack/snacks/start/snacks.nvim

local ok, Snacks = pcall(require, "snacks")
if not ok then
	return
end

local map = vim.keymap.set

Snacks.setup({
	styles = {
		dashboard = {
			border = "none",
		},
	},

	---@class snacks.scroll.Config
	---@field animate snacks.animate.Config|{}
	---@field animate_repeat snacks.animate.Config|{}|{delay:number}
	scroll = {
		animate = {
			duration = { step = 15, total = 80 },
			easing = "inOutCubic",
		},
		-- faster animation when repeating scroll after delay
		animate_repeat = {
			delay = 100, -- delay in ms before using the repeat animation
			duration = { step = 5, total = 50 },
			easing = "linear",
		},
		-- what buffers to animate
		filter = function(buf)
			return vim.g.snacks_scroll ~= false
				and vim.b[buf].snacks_scroll ~= false
				and vim.bo[buf].buftype ~= "terminal"
		end,
	},

	dashboard = {
		preset = {
			pick = nil,
			keys = {
				{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
				{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
			},
			header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██ ╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
		},
		sections = {
			{ section = "header" },
			{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
			{ pane = 1, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
			{ pane = 1, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
			(function()
				local icon = " 🍒 "
				local v = vim.version()
				local version = v.major .. "." .. v.minor .. "." .. v.patch
				return {
					align = "center",
					text = {
						{ icon .. "Neovim ", hl = "footer" },
						{ "v" .. version, hl = "special" },
					},
				}
			end)(),
			{
				pane = 2,
				icon = " ",
				desc = "Browse Repo",
				padding = 1,
				key = "b ",
				action = function()
					Snacks.gitbrowse()
				end,
				enabled = function()
					return Snacks.git.get_root() ~= nil
				end,
			},
			function()
				local in_git = Snacks.git.get_root() ~= nil
				local cmds = {
					{
						icon = " ",
						title = "Open PRs",
						cmd = "gh pr list -L 8",
						key = "P",
					},
					{
						icon = " ",
						title = "Git Status",
						cmd = "hub status --short --branch --renames",
						ttl = 5 * 60,
					},
				}
				return vim.tbl_map(function(cmd)
					return vim.tbl_extend("force", {
						pane = 2,
						section = "terminal",
						enabled = in_git,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					}, cmd)
				end, cmds)
			end,
		},
	},

	scratch = {
		root = vim.fn.expand("$HOME/Nextcloud/Notes") .. "/scratch",
	},

	terminal = {},

	lazygit = {},

	picker = {
		source = {
			"buffers",
			"diagnostics",
			"diagnostics_buffer",
			explorer = {
				layout = { preset = "default", preview = true },
				auto_close = true,
			},
			"files",
			"grep",
			"grep_buffers",
			"lsp_config",
			"lsp_declarations",
			"lsp_definitions",
			"lsp_implementations",
			"lsp_references",
			"lsp_symbols",
			"lsp_type_definitions",
			"marks",
			"notifications",
			"registers",
			"search_history",
			"smart",
		},
	},
})

-- Scratch
map("n", "<localleader>sn", function()
	Snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })
map("n", "<localleader>st", function()
	Snacks.scratch.select()
end, { desc = "Select Scratch Buffer" })

-- Picker
map("n", "<leader>ff", function()
	local utils = require("lspconfig.util")
	local root = utils.root_pattern("package-lock.json", "yarn.lock", ".git")(".")
	Snacks.picker.files({
		cwd = root,
		hidden = true,
		ignored = false,
	})
end, { desc = "Find Files including hidden" })
map("n", "<leader>f.", function()
	local utils = require("lspconfig.util")
	local root = utils.root_pattern("package-lock.json", "yarn.lock", ".git")(".")
	Snacks.picker.files({
		cwd = root,
		hidden = true,
		ignored = true,
	})
end, { desc = "Find Files including ignored" })
map("n", "<leader> ", function()
	Snacks.picker.files({ cwd = vim.fn.expand("$HOME"), hidden = true })
end, { desc = "Find Files" })
map("n", "<leader>E", function()
	local utils = require("lspconfig.util")
	local cwd = utils.root_pattern("package.json", "yarn.lock", ".git")(".")
	Snacks.notify(cwd)
	Snacks.explorer({
		layout = { preset = "default", preview = true },
		cwd = cwd,
		ignored = true,
		hidden = true,
		auto_close = true,
	})
end, { desc = "File explorer (monorepo root)" })
map("n", "<leader>e", function()
	Snacks.explorer({
		layout = { preset = "default", preview = true },
		ignored = true,
		hidden = true,
		auto_close = true,
	})
end, { desc = "File explorer" })
map("n", "<leader>;", function()
	Snacks.picker.resume()
end, { desc = "Resume last picker" })
map("n", "<leader>sg", function()
	local utils = require("lspconfig.util")
	local package = utils.root_pattern("package.json")(".")
	Snacks.picker.grep({ cwd = package })
end, { desc = "Grep in current package" })
map("n", "<leader>ss", function()
	Snacks.picker.smart()
end, { desc = "Smart Find Files" })
map("n", "<leader>fp", function()
	Snacks.picker.projects({
		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "package-lock.json", "Makefile", "yarn.lock" },
	})
end)

-- Terminal
map("n", "<leader>to", function()
	Snacks.terminal.open()
end, { desc = "Open terminal" })
map("n", "<leader>tt", function()
	Snacks.terminal.toggle()
end, { desc = "Toggle terminal" })

-- LazyGit
map("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Open lazygit" })

-- OpenCode AI (via Snacks terminal)
map("n", "<leader>oc", function()
	Snacks.terminal("opencode", { cwd = vim.fn.getcwd(), esc_esc = false, ctrl_hjkl = false })
end, { desc = "Open OpenCode AI" })
