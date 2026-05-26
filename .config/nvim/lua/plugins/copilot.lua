-- Install: ~/.local/share/nvim/site/pack/copilot/start/copilot.vim
-- Install: ~/.local/share/nvim/site/pack/copilot/start/CopilotChat.nvim
-- Setup: :Copilot setup  (first time)

local map = vim.keymap.set

-- copilot.vim
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
vim.g.copilot_filetypes = {
	["*"] = true,
	gitcommit = true,
	markdown = true,
	yaml = true,
}

map("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
	desc = "Accept Copilot suggestion",
})
map("i", "<M-]>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
map("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })
map("i", "<M-\\>", "<Plug>(copilot-suggest)", { desc = "Trigger Copilot suggestion" })
map("i", "<C-l>", "<Plug>(copilot-accept-word)", { desc = "Accept Copilot word" })

-- CopilotChat
local ok, CopilotChat = pcall(require, "CopilotChat")
if not ok then
	return
end

CopilotChat.setup({
	debug = false,
	model = "gpt-4o",
	window = {
		layout = "vertical",
		width = 0.4,
		height = 1.0,
		border = "rounded",
		relative = "editor",
	},
	mappings = {
		reset = { normal = "<C-x>", insert = "<C-x>" },
		submit_prompt = { normal = "<CR>", insert = "<C-s>" },
		accept_diff = { normal = "<C-y>", insert = "<C-y>" },
		jump_to_diff = { normal = "gj" },
		quickfix_answers = { normal = "gq" },
		yank_diff = { normal = "gy", register = '"' },
		show_diff = { normal = "gd" },
		show_info = { normal = "gi" },
		show_context = { normal = "gc" },
	},
})

map("n", "<leader>aa", function()
	CopilotChat.toggle()
end, { desc = "Toggle Copilot Chat" })
map("v", "<leader>aa", function()
	CopilotChat.toggle()
end, { desc = "Toggle Copilot Chat (visual)" })
map("n", "<leader>ax", function()
	CopilotChat.reset()
end, { desc = "Clear Copilot Chat" })
map("n", "<leader>aq", function()
	local input = vim.fn.input("Quick Chat: ")
	if input ~= "" then
		CopilotChat.ask(input)
	end
end, { desc = "Quick Copilot Chat" })
map("n", "<leader>ap", function()
	require("CopilotChat.integrations.fzflua").pick(CopilotChat.prompts())
end, { desc = "Copilot Prompts" })
