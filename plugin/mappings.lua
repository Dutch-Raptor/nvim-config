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

	["|"] = { function() require("smart-splits").split_right() end, "Split right" },
	["\\"] = { function() require("smart-splits").split_down() end, "Split down" },
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
		g = { require('telescope.builtin').git_files, '[F]ind [G]it files' },
		f = { require('telescope.builtin').find_files, '[F]ind [F]iles' },
		o = { require('telescope.builtin').oldfiles, '[?] Find recently opened files' },
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
		d = { vim.lsp.buf.definition, "Definition" },
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
	["<leader>q"] = { "<cmd>q<cr>", "Quit" },
	["<leader>w"] = { "<cmd>w<cr>", "Write" },

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
})
