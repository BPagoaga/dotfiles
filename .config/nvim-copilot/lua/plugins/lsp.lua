-- Native LSP configuration (Neovim 0.12 — vim.lsp.config + vim.lsp.enable)
-- Install servers:
--   npm install -g typescript typescript-language-server
--   npm install -g vscode-langservers-extracted
--   npm install -g @tailwindcss/language-server
--   brew install jdtls
--   brew install marksman

local map = vim.keymap.set

-- TS/JS
vim.lsp.config["ts_ls"] = {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
}

-- ESLint
vim.lsp.config["eslint"] = {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
		"html",
	},
	root_markers = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", "eslint.config.js", "package.json", ".git" },
	settings = {
		validate = "on",
		packageManager = "npm",
		useESLintClass = false,
		experimental = { useFlatConfig = false },
		codeActionOnSave = { enable = false, mode = "all" },
		format = false,
		quiet = false,
		onIgnoredFiles = "off",
		rulesCustomizations = {},
		run = "onType",
		nodePath = "",
		workingDirectory = { mode = "location" },
		codeAction = {
			disableRuleComment = { enable = true, location = "separateLine" },
			showDocumentation = { enable = true },
		},
	},
}

-- Tailwind CSS
vim.lsp.config["tailwindcss"] = {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"html",
		"css",
		"scss",
		"less",
		"postcss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
	},
	root_markers = { "tailwind.config.js", "tailwind.config.ts", "postcss.config.js", "package.json", ".git" },
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidScreen = "error",
				invalidTailwindDirective = "error",
				invalidVariant = "error",
				recommendedVariantOrder = "warning",
			},
			validate = true,
		},
	},
}

-- CSS / HTML / JSON (vscode-langservers-extracted)
vim.lsp.config["cssls"] = {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { "package.json", ".git" },
	settings = {
		css = { validate = true, lint = { unknownAtRules = "ignore" } },
		scss = { validate = true, lint = { unknownAtRules = "ignore" } },
		less = { validate = true },
	},
}

vim.lsp.config["html"] = {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_markers = { "package.json", ".git" },
}

vim.lsp.config["jsonls"] = {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { "package.json", ".git" },
	settings = {
		json = {
			validate = { enable = true },
			schemas = {
				{ fileMatch = { "package.json" }, url = "https://json.schemastore.org/package.json" },
				{ fileMatch = { "tsconfig.json", "tsconfig.*.json" }, url = "https://json.schemastore.org/tsconfig.json" },
				{ fileMatch = { ".eslintrc.json" }, url = "https://json.schemastore.org/eslintrc.json" },
				{ fileMatch = { ".prettierrc.json" }, url = "https://json.schemastore.org/prettierrc.json" },
			},
		},
	},
}

-- Markdown
vim.lsp.config["marksman"] = {
	cmd = { "marksman", "server" },
	filetypes = { "markdown" },
	root_markers = { ".marksman.toml", ".git" },
}

-- Java (Eclipse JDT LS)
vim.lsp.config["jdtls"] = {
	cmd = { "jdtls" },
	filetypes = { "java" },
	root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
	settings = {
		java = {
			inlayHints = { parameterNames = { enabled = "all" } },
			format = { enabled = true },
			completion = { enabled = true, guessMethodArguments = true },
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
			codeGeneration = {
				toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
				useBlocks = true,
			},
		},
	},
}

-- Enable all configured servers
vim.lsp.enable({
	"ts_ls",
	"eslint",
	"tailwindcss",
	"cssls",
	"html",
	"jsonls",
	"marksman",
	"jdtls",
})

-- LSP attach: keymaps, inlay hints, auto-format
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
	callback = function(event)
		local lmap = function(keys, func, desc)
			map("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local buf = vim.lsp.buf
		lmap("gd", buf.definition, "Go to definition")
		lmap("gD", buf.declaration, "Go to declaration")
		lmap("gr", buf.references, "Go to references")
		lmap("gI", buf.implementation, "Go to implementation")
		lmap("gt", buf.type_definition, "Go to type definition")
		lmap("K", buf.hover, "Hover documentation")
		lmap("<C-k>", buf.signature_help, "Signature help")
		lmap("<leader>rn", buf.rename, "Rename symbol")
		lmap("<leader>ca", buf.code_action, "Code action")
		lmap("<leader>ds", buf.document_symbol, "Document symbols")
		lmap("<leader>ws", buf.workspace_symbol, "Workspace symbols")
		lmap("<leader>f", function()
			buf.format({ async = true })
		end, "Format buffer")

		-- Inlay hints toggle (Nvim 0.10+)
		lmap("<leader>ih", function()
			vim.lsp.inlay_hint.enable(
				not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
				{ bufnr = event.buf }
			)
		end, "Toggle inlay hints")

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- Auto-fix ESLint on save
		if client and client.name == "eslint" then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = event.buf,
				callback = function()
					vim.cmd("EslintFixAll")
				end,
			})
		end

		-- Prettier format on save for web filetypes
		local prettier_fts = {
			typescript = true,
			typescriptreact = true,
			javascript = true,
			javascriptreact = true,
			css = true,
			scss = true,
			html = true,
			json = true,
			markdown = true,
		}
		if prettier_fts[vim.bo[event.buf].filetype] then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = event.buf,
				callback = function()
					vim.lsp.buf.format({ async = false, name = "ts_ls" })
				end,
			})
		end

		-- Highlight symbol under cursor
		if client and client.supports_method("textDocument/documentHighlight") then
			local hl_group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. event.buf, { clear = true })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = hl_group,
				callback = buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = hl_group,
				callback = buf.clear_references,
			})
		end
	end,
})

-- Diagnostic display
vim.diagnostic.config({
	virtual_text = {
		enabled = true,
		spacing = 4,
		prefix = "●",
		severity = { min = vim.diagnostic.severity.HINT },
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
