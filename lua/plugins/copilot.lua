return {
  -- further customize the options set by the community
  "zbirenbaum/copilot.lua",
  config = function()
    require("copilot").setup(
      {
        suggestion = {
          enabled = true,
            auto_trigger =true,
          keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<C-.>",
            prev = "<C-,>",
            dismiss = "<C/>",
          },
        },
        filetypes = {
          markdown = true,
          yaml = true,
        },
        panel = {
          enabled = false,
          
          
        },
      })
  end
}
