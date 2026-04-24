-- UI plugins:
--   ~/.local/share/nvim/site/pack/lualine/start/lualine.nvim
--   ~/.local/share/nvim/site/pack/markdown/start/render-markdown.nvim

-- lualine
local ok_ll, lualine = pcall(require, "lualine")
if ok_ll then
	lualine.setup({
		options = {
			theme = "tokyonight",
			globalstatus = true,
			disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
			component_separators = "",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { { "mode", icon = "" } },
			lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
			lualine_c = {
				{ "filename", path = 1, symbols = { modified = "  ", readonly = " ", unnamed = " " } },
			},
			lualine_x = {
				function()
					local ok, copilot_api = pcall(require, "copilot.api")
					if ok then
						local status = copilot_api.status.data
						return (status and status.message) or ""
					end
					return ""
				end,
				"encoding",
				"fileformat",
				{ "filetype", icon_only = true },
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	})
end

-- render-markdown.nvim
local ok_rm, render_md = pcall(require, "render-markdown")
if ok_rm then
	render_md.setup({
		enabled = true,
		file_types = { "markdown" },
		render_modes = { "n", "c" },
		heading = { enabled = true, icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " } },
		code = { enabled = true, style = "full" },
		dash = { enabled = true },
		bullet = { enabled = true },
		checkbox = { enabled = true },
		quote = { enabled = true },
		pipe_table = { enabled = true },
		callout = { enabled = true },
		link = { enabled = true },
		sign = { enabled = false },
		indent = { enabled = false },
	})
end
