-- Install:
--   ~/.local/share/nvim/site/pack/dap/start/nvim-dap
--   ~/.local/share/nvim/site/pack/dap/start/nvim-dap-ui
--   ~/.local/share/nvim/site/pack/dap/start/nvim-dap-virtual-text

local ok_dap, dap = pcall(require, "dap")
if not ok_dap then
	return
end

local map = vim.keymap.set

-- nvim-dap-virtual-text
local ok_vtext, vtext = pcall(require, "nvim-dap-virtual-text")
if ok_vtext then
	vtext.setup({
		enabled = true,
		enabled_commands = true,
		highlight_changed_variables = true,
		highlight_new_as_changed = false,
		show_stop_reason = true,
		commented = false,
		only_first_definition = true,
		all_references = false,
		filter_references_pattern = "<module",
		virt_text_pos = "eol",
	})
end

-- nvim-dap-ui
local ok_dapui, dapui = pcall(require, "dapui")
if ok_dapui then
	dapui.setup({
		icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
		layouts = {
			{
				elements = {
					{ id = "scopes", size = 0.25 },
					{ id = "breakpoints", size = 0.25 },
					{ id = "stacks", size = 0.25 },
					{ id = "watches", size = 0.25 },
				},
				size = 40,
				position = "left",
			},
			{
				elements = {
					{ id = "repl", size = 0.5 },
					{ id = "console", size = 0.5 },
				},
				size = 10,
				position = "bottom",
			},
		},
		floating = {
			max_height = nil,
			max_width = nil,
			border = "rounded",
			mappings = { close = { "q", "<Esc>" } },
		},
	})

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

-- JavaScript / TypeScript DAP (vscode-js-debug)
local ok_jsdap, jsdap = pcall(require, "dap-vscode-js")
if ok_jsdap then
	jsdap.setup({
		debugger_path = vim.fn.expand("~/.local/share/nvim/vscode-js-debug"),
		adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
	})
	for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
		dap.configurations[language] = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file (Node)",
				program = "${file}",
				cwd = "${workspaceFolder}",
				sourceMaps = true,
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach (Node)",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
				sourceMaps = true,
			},
			{
				type = "pwa-chrome",
				request = "launch",
				name = "Launch Chrome",
				url = "http://localhost:3000",
				webRoot = "${workspaceFolder}",
				sourceMaps = true,
				sourceMapPathOverrides = {
					["webpack:///./~/*"] = "${workspaceFolder}/node_modules/*",
					["webpack://?:*/*"] = "${workspaceFolder}/*",
				},
			},
		}
	end
else
	-- Fallback: manual node adapter
	dap.adapters["pwa-node"] = {
		type = "server",
		host = "localhost",
		port = "${port}",
		executable = {
			command = "node",
			args = {
				vim.fn.expand("~/.local/share/nvim/vscode-js-debug/out/src/vsDebugServer.js"),
				"${port}",
			},
		},
	}
end

-- Java DAP
dap.configurations.java = {
	{
		type = "java",
		request = "launch",
		name = "Launch Java Program",
		projectName = "${workspaceFolderBasename}",
		mainClass = "${file}",
		stopOnEntry = false,
	},
	{
		type = "java",
		request = "attach",
		name = "Attach to Java Process",
		hostName = "localhost",
		port = 5005,
	},
}

-- Keymaps
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
map("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Condition: "))
end, { desc = "DAP: Conditional Breakpoint" })
map("n", "<leader>dl", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log: "))
end, { desc = "DAP: Log Point" })
map("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
map("n", "<leader>di", dap.step_into, { desc = "DAP: Step Into" })
map("n", "<leader>do", dap.step_over, { desc = "DAP: Step Over" })
map("n", "<leader>dO", dap.step_out, { desc = "DAP: Step Out" })
map("n", "<leader>dC", dap.run_to_cursor, { desc = "DAP: Run to Cursor" })
map("n", "<leader>dq", dap.terminate, { desc = "DAP: Terminate" })
map("n", "<leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
map("n", "<leader>dR", dap.run_last, { desc = "DAP: Run Last" })
if ok_dapui then
	map({ "n", "v" }, "<leader>dh", dapui.eval, { desc = "DAP: Eval" })
	map("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
end
