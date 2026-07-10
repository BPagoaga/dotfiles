-- Install: ~/.local/share/nvim/site/pack/completion/start/blink.cmp

local ok, blink = pcall(require, "blink.cmp")
if not ok then
	return
end

blink.setup({
	snippets = {
		expand = function(snippet, _)
			vim.snippet.expand(snippet)
		end,
	},
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
	},
	completion = {
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
		menu = {
			draw = {
				treesitter = { "lsp" },
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		ghost_text = {
			enabled = vim.g.ai_cmp,
		},
	},

	-- experimental signature help support
	-- signature = { enabled = true },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	cmdline = {
		enabled = false,
	},
	keymap = {
		preset = "enter",
		["<C-y>"] = { "select_and_accept" },
	},
})
