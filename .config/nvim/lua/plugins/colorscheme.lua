-- Install: ~/.local/share/nvim/site/pack/themes/start/tokyonight.nvim

local function apply_transparency()
	local groups = {
		"Normal",
		"NormalNC",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"WinBar",
		"WinBarNC",
		"TelescopeNormal",
		"TelescopeBorder",
		"NvimTreeNormal",
		"NvimTreeNormalNC",
	}
	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
	end
end

vim.g.tokyonight_style = "storm"
vim.g.tokyonight_transparent = true
vim.g.tokyonight_terminal_colors = true

local ok, tokyonight = pcall(require, "tokyonight")
if ok then
	tokyonight.setup({
		style = "storm",
		transparent = true,
		styles = {
			sidebars = "transparent",
			floats = "transparent",
			comments = { italic = true },
			keywords = { italic = true },
			functions = {},
			variables = {},
		},
		on_highlights = function(hl, _)
			hl.FloatBorder = { fg = "#565f89" }
			hl.WinSeparator = { fg = "#565f89" }
		end,
	})
end

vim.cmd.colorscheme("tokyonight-storm")
apply_transparency()

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = apply_transparency,
})
