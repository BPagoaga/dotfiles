-- Editor enhancement plugins:
--   ~/.local/share/nvim/site/pack/pairs/start/nvim-autopairs
--   ~/.local/share/nvim/site/pack/surround/start/nvim-surround
--   ~/.local/share/nvim/site/pack/comment/start/Comment.nvim
--   ~/.local/share/nvim/site/pack/git/start/gitsigns.nvim
--   ~/.local/share/nvim/site/pack/whichkey/start/which-key.nvim
--   ~/.local/share/nvim/site/pack/mini/start/mini.nvim

local map = vim.keymap.set

-- nvim-autopairs
local ok_pairs, autopairs = pcall(require, "nvim-autopairs")
if ok_pairs then
	autopairs.setup({
		check_ts = true,
		ts_config = {
			lua = { "string" },
			javascript = { "template_string" },
		},
		fast_wrap = {
			map = "<M-e>",
			chars = { "{", "[", "(", '"', "'" },
			pattern = [=[[%'%"%>%]%)%}%,]]=],
			end_key = "$",
			keys = "qwertyuiopzxcvbnmasdfghjkl",
			check_comma = true,
			highlight = "PmenuSel",
			highlight_grey = "LineNr",
		},
		disable_filetype = { "TelescopePrompt", "spectre_panel" },
	})
end

-- nvim-surround
local ok_surround, surround = pcall(require, "nvim-surround")
if ok_surround then
	surround.setup({})
end

-- Comment.nvim
local ok_comment, Comment = pcall(require, "Comment")
if ok_comment then
	Comment.setup({
		pre_hook = function()
			local ok_tc, tc = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
			if ok_tc then
				return tc.create_pre_hook()()
			end
		end,
	})
end

-- gitsigns
local ok_gs, gitsigns = pcall(require, "gitsigns")
if ok_gs then
	gitsigns.setup({
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "󰍵" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "│" },
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			local gmap = function(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				map(mode, l, r, opts)
			end
			gmap("n", "]g", function()
				gs.next_hunk()
			end, { desc = "Next Hunk" })
			gmap("n", "[g", function()
				gs.prev_hunk()
			end, { desc = "Prev Hunk" })
			gmap("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
			gmap("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
			gmap("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Stage Hunk" })
			gmap("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Reset Hunk" })
			gmap("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
			gmap("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
			gmap("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
			gmap("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, { desc = "Blame Line" })
			gmap("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
			gmap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })
		end,
	})
end

-- which-key
local ok_wk, wk = pcall(require, "which-key")
if ok_wk then
	wk.setup({
		preset = "modern",
		delay = 500,
		icons = { mappings = true },
		spec = {
			-- Groups
			{ "<leader>f",  group = "Find/Files" },
			{ "<leader>g",  group = "Git" },
			{ "<leader>l",  group = "LSP" },
			{ "<leader>d",  group = "Debug" },
			{ "<leader>h",  group = "Hunks" },
			{ "<leader>a",  group = "AI/Copilot" },
			{ "<leader>u",  group = "UI/Notify" },
			{ "<leader>o",  group = "OpenCode" },
			{ "<leader>w",  group = "Window" },
			{ "<leader>n",  group = "Notifications" },
			{ "<leader>b",  group = "Buffers" },
			{ "<leader>c",  group = "Code" },
			{ "<leader>s",  group = "Search" },
			{ "<leader>t",  group = "Terminal" },
			{ "<leader>q",  group = "Session/Quit" },
			-- Buffer
			{ "<leader>bd", desc = "Delete buffer" },
			-- Code / LSP
			{ "<leader>ca", desc = "Code action" },
			{ "<leader>cd", desc = "Line diagnostics" },
			{ "<leader>cl", desc = "LSP Info" },
			{ "<leader>rn", desc = "Rename symbol" },
			{ "<leader>ds", desc = "Document symbols" },
			{ "<leader>ws", desc = "Workspace symbols" },
			{ "<leader>ih", desc = "Toggle inlay hints" },
			-- Diagnostics
			{ "<leader>E",  desc = "Diagnostic float" },
			{ "<leader>dq", desc = "Diagnostics to loclist" },
			{ "[d",         desc = "Previous diagnostic" },
			{ "]d",         desc = "Next diagnostic" },
			-- Git
			{ "]g",         desc = "Next hunk" },
			{ "[g",         desc = "Prev hunk" },
		},
	})
end

-- mini.ai
local ok_mini_ai, mini_ai = pcall(require, "mini.ai")
if ok_mini_ai then
	mini_ai.setup({ n_lines = 500 })
end


