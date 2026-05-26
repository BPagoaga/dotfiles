-- UI plugins:
--   ~/.local/share/nvim-copilot/site/pack/ui/start/lualine.nvim
--   ~/.local/share/nvim-copilot/site/pack/markdown/start/render-markdown.nvim

-- lualine
local ok_ll, lualine = pcall(require, "lualine")
if ok_ll then
	local icons = {
		diagnostics = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " },
		git = { added = " ", modified = " ", removed = " " },
	}

	-- Convert a highlight group's fg to a "#rrggbb" hex string for lualine
	local function hl_fg(name)
		local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
		local fg = hl and hl.fg
		if fg then return string.format("#%06x", fg) end
	end

	-- Show a pretty relative path, marking modified/readonly state
	local function pretty_path()
		local path = vim.fn.expand("%:p")
		if path == "" then
			return ""
		end
		local root = vim.fs.root(0, { ".git", "package.json", "Makefile" }) or vim.fn.getcwd()
		local rel = vim.fn.fnamemodify(path, ":~:.")
		if root and path:find(root, 1, true) == 1 then
			rel = path:sub(#root + 2)
		end
		local modified = vim.bo.modified and "  " or ""
		local readonly = (vim.bo.readonly or not vim.bo.modifiable) and "  " or ""
		return rel .. modified .. readonly
	end

	lualine.setup({
		options = {
			theme = "auto",
			globalstatus = true,
			disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				{
					"diagnostics",
					symbols = {
						error = icons.diagnostics.Error,
						warn = icons.diagnostics.Warn,
						info = icons.diagnostics.Info,
						hint = icons.diagnostics.Hint,
					},
				},
				{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
				{ pretty_path },
			},
		lualine_x = {
			-- noice command status
			{
				function() return require("noice").api.status.command.get() end,
				cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
			color = function() return { fg = hl_fg("Statement") } end,
		},
		-- noice mode status (e.g. recording macro)
		{
			function() return require("noice").api.status.mode.get() end,
			cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
			color = function() return { fg = hl_fg("Constant") } end,
		},
		-- dap status
		{
			function() return "  " .. require("dap").status() end,
			cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
			color = function() return { fg = hl_fg("Debug") } end,
		},
			-- Active LSP clients (LazyVim style)
			{
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if #clients == 0 then return "" end
					local names = {}
					for _, c in ipairs(clients) do
						-- skip copilot noise
						if c.name ~= "copilot" and c.name ~= "GitHub Copilot" then
							table.insert(names, c.name)
						end
					end
					if #names == 0 then return "" end
					return " " .. table.concat(names, ", ")
				end,
				cond = function()
					for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
						if c.name ~= "copilot" and c.name ~= "GitHub Copilot" then
							return true
						end
					end
					return false
				end,
				color = function() return { fg = hl_fg("Special") } end,
			},
			-- git diff (sourced from gitsigns)
				{
					"diff",
					symbols = {
						added = icons.git.added,
						modified = icons.git.modified,
						removed = icons.git.removed,
					},
					source = function()
						local gs = vim.b.gitsigns_status_dict
						if gs then
							return { added = gs.added, modified = gs.changed, removed = gs.removed }
						end
					end,
				},
			},
			lualine_y = {
				{ "progress", separator = " ", padding = { left = 1, right = 0 } },
				{ "location", padding = { left = 0, right = 1 } },
			},
			lualine_z = {
				function() return " " .. os.date("%R") end,
			},
		},
		extensions = { "lazy", "fzf" },
	})
end

-- render-markdown.nvim
local ok_rm, render_md = pcall(require, "render-markdown")
if ok_rm then
	render_md.setup({
		file_types = { "markdown" },
		render_modes = { "n", "c" },
		heading = { icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " } },
		code = { style = "full" },
		sign = { enabled = false },
		indent = { enabled = false },
	})
end
