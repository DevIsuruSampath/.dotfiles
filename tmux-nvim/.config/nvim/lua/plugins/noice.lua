local is_termux = (vim.env.PREFIX or ""):match("com.termux") ~= nil

return {
  {
    "folke/noice.nvim",
    enabled = not is_termux,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        progress = { enabled = true },
        hover = { enabled = true },
        signature = { enabled = true },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    enabled = not is_termux,
    opts = {
      timeout = 2500,
      background_colour = "#000000",
    },
  },
}
