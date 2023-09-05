return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    "debugloop/telescope-undo.nvim",
    'nvim-lua/plenary.nvim',
    {
      "aznhe21/actions-preview.nvim",
      config = function()
        require("actions-preview").setup {
          telescope = {
            sorting_strategy = "ascending",
            layout_strategy = "vertical",
            layout_config = {
              width = 0.8,
              height = 0.9,
              prompt_position = "top",
              preview_cutoff = 20,
              preview_height = function(_, _, max_lines)
                return max_lines - 15
              end,
            },
          },
        }
      end
    },
    "ThePrimeagen/harpoon",

  },
  cmd = "Telescope",
  opts = function()
  end,
  config = function()
    local telescope = require "telescope"
    telescope.load_extension("aerial")
    -- telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("undo")
    telescope.load_extension("harpoon")

    local actions = require "telescope.actions"
    telescope.setup(
      {
        defaults = {
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },

          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = { ["q"] = actions.close },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }
          },
        }
      })
  end
}
