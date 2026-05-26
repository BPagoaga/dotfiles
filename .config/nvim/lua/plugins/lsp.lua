-- Native LSP configuration (Neovim 0.12 — vim.lsp.config + vim.lsp.enable)
-- Install servers:
--   npm install -g @vtsls/language-server
--   npm install -g vscode-langservers-extracted
--   npm install -g @tailwindcss/language-server
--   brew install jdtls
--   brew install lua-language-server
--   brew install marksman

local map = vim.keymap.set

-- TS/JS (vtsls)
vim.lsp.config["vtsls"] = {
	cmd = { "vtsls", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	root_markers = { "package-lock.json", "yarn.lock", ".git" },
	settings = {
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true,
		},
		typescript = {
			updateImportsOnFileMove = { enabled = "always" },
			inlayHints = {
				parameterNames = { enabled = "all" },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = false },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
		},
		javascript = {
			updateImportsOnFileMove = { enabled = "always" },
			inlayHints = {
				parameterNames = { enabled = "all" },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = false },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
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
		"typescript",
		"typescriptreact",
		"vue",
		"html",
	},
	root_markers = { "package-lock.json", "yarn.lock", ".eslintrc", ".eslintrc.js", ".eslintrc.json", "eslint.config.js", ".git" },
	settings = {
		validate = "on",
		packageManager = nil,
		useESLintClass = false,
		experimental = { useFlatConfig = false },
		codeActionOnSave = { enable = false, mode = "all" },
		format = false,
		quiet = false,
		onIgnoredFiles = "off",
		rulesCustomizations = {},
		run = "onType",
		problems = { shortenToSingleLine = false },
		nodePath = "",
		workingDirectory = { mode = "location" },
		codeAction = {
			disableRuleComment = { enable = true, location = "separateLine" },
			showDocumentation = { enable = true },
		},
	},
	handlers = {
		["eslint/openDoc"] = function(_, result)
			if result then vim.ui.open(result.url) end
			return {}
		end,
		["eslint/confirmESLintExecution"] = function()
			return 4 -- approved
		end,
		["eslint/probeFailed"] = function()
			vim.notify("[eslint] Probe failed.", vim.log.levels.WARN)
			return {}
		end,
		["eslint/noLibrary"] = function()
			vim.notify("[eslint] Unable to find ESLint library.", vim.log.levels.WARN)
			return {}
		end,
	},
	on_attach = function(client, bufnr)
		-- Set workspaceFolder so the server knows the root (important in monorepos)
		local root = client.config.root_dir or vim.fn.getcwd()
		client.config.settings.workspaceFolder = {
			uri = root,
			name = vim.fn.fnamemodify(root, ":t"),
		}
		client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
	end,
}

-- Tailwind CSS
vim.lsp.config["tailwindcss"] = {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"html",
		"css",
		"scss",
		"less",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
	},
	root_markers = { "tailwind.config.js", "tailwind.config.ts", "postcss.config.js", "package-lock.json", "yarn.lock", ".git" },
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
	root_markers = { "package-lock.json", "yarn.lock", ".git" },
	settings = {
		css = { validate = true, lint = { unknownAtRules = "ignore" } },
		scss = { validate = true, lint = { unknownAtRules = "ignore" } },
		less = { validate = true },
	},
}

vim.lsp.config["html"] = {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_markers = { "package-lock.json", "yarn.lock", ".git" },
}

vim.lsp.config["jsonls"] = {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { "package-lock.json", "yarn.lock", ".git" },
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

-- Lua
vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
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
	"vtsls",
	"eslint",
	"tailwindcss",
	"cssls",
	"html",
	"jsonls",
	"lua_ls",
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
		lmap("gvd", function()
			vim.cmd("vsplit")
			buf.definition()
		end, "Go to definition (vertical split)")
		lmap("ghd", function()
			vim.cmd("split")
			buf.definition()
		end, "Go to definition (horizontal split)")
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

-- Diagnostic navigation
map("n", "<C-j>", function() vim.diagnostic.goto_next({ float = true }) end, { desc = "Next diagnostic" })
map("n", "<C-k>", function() vim.diagnostic.goto_prev({ float = true }) end, { desc = "Prev diagnostic" })
