return
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  init = function() vim.g.neo_tree_remove_legacy_commands = true end,
  opts = function()
    return {
      auto_clean_after_session_restore = true,
      close_if_last_window = true,
      window = {
        mappings = {
          ["<space>"] = false, -- disable space until we figure out which-key disabling
        },
      },

    }
  end
}
