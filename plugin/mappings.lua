local map = function(m, l, r, desc, opts)
	opts = opts or { noremap = true, silent = true }
	desc = desc or nil
	opts.desc = desc
	vim.keymap.set(m, l, r, opts)
end

local wk = require("which-key")

local vscode = nil
if vim.g.vscode then
	print("VSCode detected, using VSCode mappings")
	vscode = require("vscode-neovim")
end


-- Define different mappings for VSCode and Neovim
local nvim_vscode = function(nvim_fn, vscode_fn, desc)
	if vim.g.vscode then
		return {
			vscode_fn, desc
		}
	else
		return {
			nvim_fn, desc
		}
	end
end

-- Define mapping for only Neovim
local nvim = function(nvim_fn, desc)
	if vim.g.vscode then
		return nil
	else
		return {
			nvim_fn, desc
		}
	end
end

-- define the same mapping for neovim and vscode
local either = function(cmd, desc)
	return {
		cmd, desc
	}
end

wk.register(
-- Normal Mode
	{
		-- NeoTree
		["<leader>x"] = nvim_vscode(
			"<cmd>Neotree toggle<cr>",
			function()
				vscode.call("workbench.action.toggleSidebarVisibility")
			end,
			"Toggle Explorer"
		),

		["<leader>o"] = nvim_vscode(function()
				if vim.bo.filetype == "neo-tree" then
					vim.cmd.wincmd "p"
				else
					vim.cmd.Neotree "focus"
				end
			end,
			function()
				vscode.call("workbench.view.explorer")
			end,

			"Toggle Explorer Focus"
		),


		-- Smart Splits
		["<C-h>"] = nvim_vscode(function()
				require("smart-splits").move_cursor_left()
			end,
			function() vscode.call("workbench.action.navigateLeft") end,
			"Move to left split"
		),
		["<C-j>"] = nvim_vscode(
			function() require("smart-splits").move_cursor_down() end,
			function() vscode.call("workbench.action.navigateDown") end,
			"Move to below split"
		),
		["<C-k>"] = nvim_vscode(
			function() require("smart-splits").move_cursor_up() end,
			function() vscode.call("workbench.action.navigateUp") end,
			"Move to above split"
		),
		["<C-l>"] = nvim_vscode(
			function() require("smart-splits").move_cursor_right() end,
			function() vscode.call("workbench.action.navigateRight") end,
			"Move to right split"
		),
		["<C-Up>"] = nvim_vscode(
			function() require("smart-splits").resize_up() end,
			function() vscode.call("workbench.action.increaseViewSize") end,
			"Resize split up"
		),
		["<C-Down>"] = nvim_vscode(
			function() require("smart-splits").resize_down() end,
			function() vscode.call("workbench.action.decreaseViewSize") end,
			"Resize split down"
		),
		["<C-Left>"] = nvim_vscode(
			function() require("smart-splits").resize_left() end,
			function() vscode.call("workbench.action.decreaseViewSize") end,
			"Resize split left"
		),
		["<C-Right>"] = nvim_vscode(
			function() require("smart-splits").resize_right() end,
			function() vscode.call("workbench.action.increaseViewSize") end,
			"Resize split right"
		),

		["|"] = nvim_vscode(
			function() require("focus").split_command("l") end,
			function() vscode.call("workbench.action.splitEditorRight") end,
			"Split right"
		),
		["\\"] = nvim_vscode(
			function() require("focus").split_command("j") end,
			function() vscode.call("workbench.action.splitEditorDown") end,
			"Split down"
		),
		-- Lazygit
		["<leader>gg"] = nvim(
			"<cmd>LazyGit<cr>",
			"Open LazyGit"
		),

		-- Telescope
		["<leader>u"] = nvim(function() require("telescope").extensions.undo.undo() end, "Undo Tree"),

		-- See `:help telescope.builtin`
		["<leader>b"] = nvim_vscode(
			require('telescope.builtin').buffers,
			function() vscode.call("workbench.action.quickOpen") end,
			'[ ] Find existing buffers'
		),
		["<leader>/"] = nvim_vscode(
			function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes')
					.get_dropdown {
						winblend = 10,
						previewer = false,
					})
			end,
			function() vscode.call("actions.find") end,
			'[/] Fuzzily search in current buffer'),


		["<leader>f"] = { name = "Telescope files",

			f = nvim(require('telescope.builtin').find_files, '[F]ind [F]iles'),
			o = nvim(require('telescope.builtin').oldfiles, 'Find recently opened files'),
			["<CR>"] = nvim(function() require("telescope.builtin").resume() end, "Resume previous search")
		},

		["<leader>s"] = { name = "Telescope Search",
			h = nvim(require('telescope.builtin').help_tags, '[S]earch [H]elp'),
			w = nvim(require('telescope.builtin').grep_string, '[S]earch current [W]ord'),
			g = nvim(require('telescope.builtin').live_grep, '[S]earch by [G]rep'),
			d = nvim(require('telescope.builtin').diagnostics, '[S]earch [D]iagnostics'),
		},


		-- LSP
		["<leader>l"] = { name = "LSP",
			a = nvim_vscode(
				function() require("actions-preview").code_actions() end,
				function() vscode.call("editor.action.codeAction") end,
				"Code actions preview"
			),
			g = nvim(vim.lsp.buf.definition, "Go to definition"),
			f = nvim_vscode(
				vim.lsp.buf.formatting,
				function() vscode.call("editor.action.formatDocument") end,
				"Format"
			),
			d = nvim_vscode(
				function() vim.diagnostic.open_float() end,
				function() vscode.call("editor.action.showHover") end,
				"Hover Diagnostics"
			),
			e = nvim(function() require("telescope.builtin").diagnostics() end, "Document Diagnostics"),
			D = nvim(function() require("telescope.builtin").lsp_implementations() end, "Declaration"),
			i = nvim(vim.lsp.buf.implementation, "Implementation"),
			R = nvim(
				function() require("telescope.builtin").lsp_references() end,

				"References"
			),
			r = nvim_vscode(
				vim.lsp.buf.rename,
				function() require('vscode-neovim').call("editor.action.rename") end,
				"Rename"
			),
			x = nvim(vim.lsp.buf.signature_help, "Signature Help"),
			t = nvim(vim.lsp.buf.type_definition, "Type Definition"),
			-- Document Symbols
			s = nvim_vscode(
				":AerialToggle<cr>",
				function() require('vscode-neovim').call("outline.focus") end,
				"Toggle Aerial"
			),

			w = {
				name = "Workspace",
				a = nvim(vim.lsp.buf.add_workspace_folder, "Add Folder"),
				r = nvim(vim.lsp.buf.remove_workspace_folder, "Remove Folder"),
				l = nvim(function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "List Folders"),

				s = nvim(vim.lsp.buf.workspace_symbol, "Workspace Symbols"),
			},
		},
		["K"] = nvim_vscode(
			vim.lsp.buf.hover,
			function() require('vscode-neovim').call("editor.action.showHover") end,
			"Hover"
		),

		-- Vim command shortcuts
		["<leader>q"] = { name = "Quit options",
			q = nvim_vscode(
				"<cmd>q<cr>",
				function() vscode.call("workbench.action.closeActiveEditor") end,
				"Quit"
			),
			a = nvim_vscode(
				"<cmd>qa<cr>",
				function() vscode.call("workbench.action.closeAllEditors") end,
				"Quit all"
			),
			w = nvim_vscode(
				"<cmd>wq<cr>",
				function() vscode.call("workbench.action.closeActiveEditor") end,
				"Write and quit"
			),
			g = nvim_vscode(
				"<cmd>wqa<cr>",
				function()
					vscode.call("workbench.action.files.saveAll")
					vscode.call("workbench.action.closeAllEditors")
				end,
				"Write and quit all"
			),

		},
		["<leader>w"] = nvim_vscode(
			"<cmd>w<cr>",
			function() vscode.call("workbench.action.files.save") end,
			"Write"
		),
		["<leader>W"] = nvim_vscode(
			"<cmd>wa<cr>",
			function() vscode.call("workbench.action.files.saveAll") end,
			"Write all"
		),


		-- Git

		["<leader>g"] = { name = "Git",
			b = nvim("<cmd>Git blame<cr>", "Blame"),
			c = nvim("<cmd>Git commit<cr>", "Commit"),
			d = nvim("<cmd>Git diff<cr>", "Diff"),
			D = nvim("<cmd>Git diff --cached<cr>", "Diff staged"),
			l = nvim("<cmd>Git log<cr>", "Log"),
			p = nvim("<cmd>Git push<cr>", "Push"),
			P = nvim("<cmd>Git pull<cr>", "Pull"),
			s = nvim("<cmd>Git<cr>", "Status"),
		},

		-- Harpoon

		["<leader>ib"] = nvim_vscode(
			function() require("harpoon.mark").add_file() end,
			function() vscode.call("vscode-harpoon.addEditor") end,
			"Harpoon: add file"
		),
		["<leader>h"] = nvim_vscode(
			function() require("harpoon.ui").toggle_quick_menu() end,
			function() vscode.call("vscode-harpoon.editEditors") end,
			"Harpoon: toggle quick menu"
		),

		["<leader>n"] = nvim_vscode(
			function() require("harpoon.ui").nav_file(1) end,
			function() vscode.call("vscode-harpoon.gotoEditor1") end,
			"Harpoon: navigate to file 1"
		),
		["<leader>e"] = nvim_vscode(
			function() require("harpoon.ui").nav_file(2) end,
			function() vscode.call("vscode-harpoon.gotoEditor2") end,
			"Harpoon: navigate to file 2"
		),
		["<leader>a"] = nvim_vscode(
			function() require("harpoon.ui").nav_file(3) end,
			function() vscode.call("vscode-harpoon.gotoEditor3") end,
			"Harpoon: navigate to file 3"
		),
		["<leader>in"] = nvim_vscode(
			function() require("harpoon.ui").nav_file(4) end,
			function() vscode.call("vscode-harpoon.gotoEditor4") end,
			"Harpoon: navigate to file 4"
		),
		["<leader>ie"] = nvim_vscode(
			function() require("harpoon.ui").nav_file(5) end,
			function() vscode.call("vscode-harpoon.gotoEditor5") end,
			"Harpoon: navigate to file 5"
		),
		["<leader>ia"] = nvim_vscode(
			function() require("harpoon.ui").nav_file(6) end,
			function() vscode.call("vscode-harpoon.gotoEditor6") end,
			"Harpoon: navigate to file 6"
		),
		["<leader>io"] = nvim_vscode(
			function() require("harpoon.ui").nav_file(7) end,
			function() vscode.call("vscode-harpoon.gotoEditor7") end,
			"Harpoon: navigate to file 7"
		),


		-- swap lines
		["<M-k>"] = nvim(":m .-2<CR>==", "Move line up"),
		["<M-j>"] = nvim(":m .+1<CR>==", "Move line down"),



		-- Trouble
		["<leader>t"] = { name = "Trouble",
			d = nvim(function() require("trouble").toggle { mode = "lsp_definitions" } end,
				"Definitions"),
			r = nvim(function() require("trouble").toggle { mode = "lsp_references" } end,
				"References"),
			t = nvim(function() require("trouble").toggle { mode = "lsp_type_definitions" } end,
				"Type Definitions"),
			s = nvim(function() require("trouble").toggle { mode = "document_diagnostics" } end,
				"Document Diagnostics"),
			e = nvim_vscode(
				function() require("trouble").toggle { mode = "workspace_diagnostics" } end,
				function() vscode.call("workbench.actions.view.problems") end,
				"Workspace Diagnostics"
			),
			q = nvim(function() require("trouble").toggle { mode = "quickfix" } end, "Quickfix"),
			l = nvim(function() require("trouble").toggle { mode = "loclist" } end, "Location List"),
			n = nvim_vscode(
				function() require("trouble").next { skip_groups = true, jump = true } end,
				function() vscode.call("editor.action.marker.nextInFiles") end,
				"Next"
			),
			p = nvim_vscode(
				function() require("trouble").previous { skip_groups = true, jump = true } end,
				function() vscode.call("editor.action.marker.prevInFiles") end,
				"Previous"
			),
			R = nvim(function() require("trouble").refresh() end, "Refresh"),
		},

		-- Flash
		["<leader>r"] = { name = "Flash",
			d = nvim(function()
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
			end, "Diagnostics"),

			k = either(function()
				require("flash").jump({
					action = function(match, state)
						vim.api.nvim_win_call(match.win, function()
							vim.api.nvim_win_set_cursor(match.win, match.pos)
							if vim.g.vscode then
								require('vscode-neovim').call(
									"editor.action.showHover")
							else
								vim.lsp.buf.hover()
								state:restore()
							end
						end)
					end
				})
			end, "Hover"),

			r = either(function() require("flash").jump({ continue = true }) end, "Continue last flash"),
			l = nvim(function()
				require("flash").jump({
					search = { mode = "search", max_length = 0 },
					label = { after = { 0, 0 } },
					pattern = "^"
				})
			end, "Search"),

		},

		-- Multi line objects
		["<leader>m"] = { name = "Split or join multiline object",
			m = nvim(function() require("treesj").toggle() end, "Toggle multiline"),
			s = nvim(function() require("treesj").split() end, "Split multiline"),
			j = nvim(function() require("treesj").join() end, "Join multiline"),
		},

	})

-- insert mode

wk.register({
	["<m-k>"] = { "<ESC>:m .-2<CR>==gi", desc = "Move line up" },
	["<m-j>"] = { "<ESC>:m .+1<CR>==gi", desc = "Move line down" },
}, { mode = "i" })

-- visual mode

wk.register({

	-- paste without losing register
	["<leader>p"] = { '"_dP', "Paste without losing register" },

	-- code actions
	["<leader>la"] = { nvim_vscode(
		function() require("actions-preview").code_actions() end,
		function() vscode.call("editor.action.codeAction") end,
		"Code actions preview"
	), "Code actions preview" },
}, { mode = "v" })
