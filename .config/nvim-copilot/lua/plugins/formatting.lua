-- Install: ~/.local/share/nvim/site/pack/format/start/conform.nvim
-- npm install -g prettier

local ok, conform = pcall(require, "conform")
if not ok then
	return
end

local map = vim.keymap.set

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		markdown = { "prettier" },
		yaml = { "prettier" },
		java = { "google-java-format" },
	},
	format_on_save = {
		timeout_ms = 3000,
		lsp_fallback = true,
	},
	formatters = {
		prettier = {
			prepend_args = function(_, ctx)
				local config_files = {
					".prettierrc",
					".prettierrc.js",
					".prettierrc.json",
					".prettierrc.yaml",
					".prettierrc.yml",
					"prettier.config.js",
				}
				for _, f in ipairs(config_files) do
					if vim.fn.filereadable(ctx.dirname .. "/" .. f) == 1 then
						return {}
					end
				end
				return { "--tab-width", "2", "--single-quote", "--trailing-comma", "es5", "--print-width", "100" }
			end,
		},
	},
})

map("n", "<leader>lf", function()
	conform.format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer (conform)" })
