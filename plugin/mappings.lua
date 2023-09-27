local map = function(m, l, r, desc, opts)
	opts = opts or { noremap = true, silent = true }
	desc = desc or nil
	opts.desc = desc
	vim.keymap.set(m, l, r, opts)
end

local wk = require("which-key")

wk.register({
	-- NeoTree
	["<leader>x"] = { "<cmd>Neotree toggle<cr>", "Toggle Explorer" },
	["<leader>o"] = { function()
		if vim.bo.filetype == "neo-tree" then
			vim.cmd.wincmd "p"
		else
			vim.cmd.Neotree "focus"
		end
	end,
		"Toggle Explorer Focus"
	},


	-- Smart Splits
	["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, "Move to left split" },
	["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, "Move to below split" },
	["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, "Move to above split" },
	["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, "Move to right split" },
	["<C-Up>"] = { function() require("smart-splits").resize_up() end, "Resize split up" },
	["<C-Down>"] = { function() require("smart-splits").resize_down() end, "Resize split down" },
	["<C-Left>"] = { function() require("smart-splits").resize_left() end, "Resize split left" },
	["<C-Right>"] = { function() require("smart-splits").resize_right() end, "Resize split right" },

	["|"] = { function() require("focus").split_command("l") end, "Split right" },
	["\\"] = { function() require("focus").split_command("j") end, "Split down" },
	-- Lazygit
	["<leader>gg"] = { "<cmd>LazyGit<cr>", "Open LazyGit" },

	-- Telescope
	["<leader>u"] = { function() require("telescope").extensions.undo.undo() end, "Undo Tree" },

	-- See `:help telescope.builtin`
	["<leader>b"] = { require('telescope.builtin').buffers, '[ ] Find existing buffers' },
	["<leader>/"] = { function()
		-- You can pass additional configuration to telescope to change theme, layout, etc.
		require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
			winblend = 10,
			previewer = false,
		})
	end, '[/] Fuzzily search in current buffer' },


	["<leader>f"] = { name = "Telescope files",

		f = { require('telescope.builtin').find_files, '[F]ind [F]iles' },
		o = { require('telescope.builtin').oldfiles, 'Find recently opened files' },
		["<CR>"] = { function() require("telescope.builtin").resume() end, "Resume previous search" }
	},

	["<leader>s"] = { name = "Telescope Search",
		h = { require('telescope.builtin').help_tags, '[S]earch [H]elp' },
		w = { require('telescope.builtin').grep_string, '[S]earch current [W]ord' },
		g = { require('telescope.builtin').live_grep, '[S]earch by [G]rep' },
		d = { require('telescope.builtin').diagnostics, '[S]earch [D]iagnostics' },
	},


	-- LSP
	["<leader>l"] = { name = "LSP",
		a = { function() require("actions-preview").code_actions() end, "Code actions preview" },
		g = { vim.lsp.buf.definition, "Go to definition" },
		f = { vim.lsp.buf.formatting, "Format" },
		d = { function() vim.diagnostic.open_float() end,
			"Hover Diagnostics" },
		e = { function() require("telescope.builtin").diagnostics() end, "Document Diagnostics" },
		D = { function() require("telescope.builtin").lsp_implementations() end, "Declaration" },
		i = { vim.lsp.buf.implementation, "Implementation" },
		R = { function() require("telescope.builtin").lsp_references() end, "References" },
		r = { vim.lsp.buf.rename, "Rename" },
		x = { vim.lsp.buf.signature_help, "Signature Help" },
		t = { vim.lsp.buf.type_definition, "Type Definition" },
		-- Document Symbols
		s = { ":AerialToggle<cr>", "Toggle Aerial" },

		w = {
			name = "Workspace",
			a = { vim.lsp.buf.add_workspace_folder, "Add Folder" },
			r = { vim.lsp.buf.remove_workspace_folder, "Remove Folder" },
			l = { function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "List Folders" },

			s = { vim.lsp.buf.workspace_symbol, "Workspace Symbols" },
		},
	},
	["K"] = { vim.lsp.buf.hover, "Hover" },

	-- Vim command shortcuts
	["<leader>q"] = { name = "Quit options",
		q = { "<cmd>q<cr>", "Quit" },
		a = { "<cmd>qa<cr>", "Quit all" },
		w = { "<cmd>wq<cr>", "Write and quit" },
		g = { "<cmd>wqa<cr>", "Write and quit all" },

	},
	["<leader>w"] = { "<cmd>w<cr>", "Write" },
	["<leader>W"] = { "<cmd>wa<cr>", "Write" },


	-- Git

	["<leader>g"] = { name = "Git",
		b = { "<cmd>Git blame<cr>", "Blame" },
		c = { "<cmd>Git commit<cr>", "Commit" },
		d = { "<cmd>Git diff<cr>", "Diff" },
		D = { "<cmd>Git diff --cached<cr>", "Diff staged" },
		l = { "<cmd>Git log<cr>", "Log" },
		p = { "<cmd>Git push<cr>", "Push" },
		P = { "<cmd>Git pull<cr>", "Pull" },
		s = { "<cmd>Git<cr>", "Status" },
	},

	-- Harpoon

	["<C-b>"] = { function() require("harpoon.mark").add_file() end, "Harpoon: add file" },
	["<leader>h"] = { function() require("harpoon.ui").toggle_quick_menu() end, "Harpoon: toggle quick menu" },

	["<leader>n"] = { function() require("harpoon.ui").nav_file(1) end, "Harpoon: navigate to file 1" },
	["<leader>e"] = { function() require("harpoon.ui").nav_file(2) end, "Harpoon: navigate to file 2" },
	["<leader>a"] = { function() require("harpoon.ui").nav_file(3) end, "Harpoon: navigate to file 3" },

	-- swap lines
	["<A-j>"] = { ":m .+1<CR>==", desc = "Move line down" },
	["<A-k>"] = { ":m .-2<CR>==", desc = "Move line up" },

	["<leader>v"] = { name = "Split or join multiline object" },
	["<leader>vj"] = { ":TSJToggle<cr>", desc = "Toggle multiline" },
	["<leader>vv"] = { ":TSJToggle<cr>", desc = "Toggle multiline" },
	["<leader>vl"] = { ":TSJSplit<cr>", desc = "Split multiline" },
	["<leader>vk"] = { ":TSJJoin<cr>", desc = "Join multiline" },

})

-- insert mode

wk.register({
	["<A-k>"] = { "<ESC>:m .-2<CR>==gi", desc = "Move line up" },
	["<A-j>"] = { "<ESC>:m .+1<CR>==gi", desc = "Move line down" },
}, { mode = "i" })
