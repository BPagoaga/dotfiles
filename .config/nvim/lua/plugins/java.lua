-- nvim-java: full Java support via jdtls + lspconfig
-- Install: see install-plugins.sh (java pack)
-- Requires: brew install google-java-format jdtls

local ok, java = pcall(require, "java")
if not ok then
	return
end

java.setup({
	jdtls = { version = "1.54.0" },
	lombok = { enable = false },
	java_test = { enable = false },
	java_debug_adapter = { enable = false },
	spring_boot_tools = { enable = false },
	jdk = { auto_install = false },
})

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
	return
end

lspconfig.jdtls.setup({
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
})
