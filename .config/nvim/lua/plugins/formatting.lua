-- Install: ~/.local/share/nvim/site/pack/format/start/conform.nvim
-- npm install -g prettier

local ok, conform = pcall(require, "conform")
if not ok then
	return
end

local map = vim.keymap.set

conform.setup({
	formatters = {
		["google-java-format"] = {
			-- google-java-format 1.24+ requires these flags on Java < 21
			prepend_args = {
				"--add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED",
				"--add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED",
				"-jar",
				"/opt/homebrew/opt/google-java-format/libexec/google-java-format.jar",
				"-",
			},
			command = "java",
		},
	},
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
})

map("n", "<leader>lf", function()
	conform.format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer (conform)" })
