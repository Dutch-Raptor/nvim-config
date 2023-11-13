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
	["<leader>pn"] = { function() require("harpoon.ui").nav_file(4) end, "Harpoon: navigate to file 4" },
	["<leader>pe"] = { function() require("harpoon.ui").nav_file(5) end, "Harpoon: navigate to file 5" },
	["<leader>pa"] = { function() require("harpoon.ui").nav_file(6) end, "Harpoon: navigate to file 6" },


	-- swap lines
	["<M-j>"] = { ":m .+1<CR>==", desc = "Move line down" },
	["<M-k>"] = { ":m .-2<CR>==", desc = "Move line up" },


	-- Trouble
	["<leader>t"] = { name = "Trouble",
		d = { function() require("trouble").toggle { mode = "lsp_definitions" } end, "Definitions" },
		r = { function() require("trouble").toggle { mode = "lsp_references" } end, "References" },
		t = { function() require("trouble").toggle { mode = "lsp_type_definitions" } end, "Type Definitions" },
		s = { function() require("trouble").toggle { mode = "document_diagnostics" } end,
			"Document Diagnostics" },
		e = { function() require("trouble").toggle { mode = "workspace_diagnostics" } end,
			"Workspace Diagnostics" },
		q = { function() require("trouble").toggle { mode = "quickfix" } end, "Quickfix" },
		l = { function() require("trouble").toggle { mode = "loclist" } end, "Location List" },
		n = { function() require("trouble").next { skip_groups = true, jump = true } end, "Next" },
		p = { function() require("trouble").previous { skip_groups = true, jump = true } end, "Previous" },
		R = { function() require("trouble").refresh() end, "Refresh" },
	},

	-- Flash
	["<leader>r"] = { name = "Flash",
		d = { function()
			require("flash").jump({
				matcher = function(win)
					---@param diag Diagnostic
					return vim.tbl_map(function(diag)
						return {
							pos = { diag.lnum + 1, diag.col },
							end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
						}
					end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
				end,
				action = function(match, state)
					vim.api.nvim_win_call(match.win, function()
						vim.api.nvim_win_set_cursor(match.win, match.pos)
						print(match.pos)
						vim.diagnostic.open_float()
					end)
					state:restore()
				end
			})
		end, "Diagnostics" },

		k = { function()
			require("flash").jump({
				action = function(match, state)
					vim.api.nvim_win_call(match.win, function()
						vim.api.nvim_win_set_cursor(match.win, match.pos)
						vim.lsp.buf.hover()
					end)
					state:restore()
				end
			})
		end, "Hover" },

		r = { function() require("flash").jump({ continue = true }) end, "Continue last flash" },
		l = { function()
			require("flash").jump({
				search = { mode = "search", max_length = 0 },
				label = { after = { 0, 0 } },
				pattern = "^"
			})
		end, "Search" },

	},

	-- Multi line objects
	["<leader>m"] = { name = "Split or join multiline object",
		m = { function() require("treesj").toggle() end, "Toggle multiline" },
		s = { function() require("treesj").split() end, "Split multiline" },
		j = { function() require("treesj").join() end, "Join multiline" },
	},

})

-- insert mode

wk.register({
	["<A-k>"] = { "<ESC>:m .-2<CR>==gi", desc = "Move line up" },
	["<A-j>"] = { "<ESC>:m .+1<CR>==gi", desc = "Move line down" },
}, { mode = "i" })
