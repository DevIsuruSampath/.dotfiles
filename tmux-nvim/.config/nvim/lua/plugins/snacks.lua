return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = false },
      input = { enabled = true },
      dashboard = { enabled = false },
      indent = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      { "<leader><space>", function() Snacks.picker.files() end, desc = "Snacks: files" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Snacks: grep" },
      { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Snacks: notifications" },
    },
  },
}
