return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- Start recording when a file is opened
    opts = {
      -- Options for session handling
      need = 1, -- Only save session if at least 1 file buffer is open
      branch = true, -- Create separate sessions for different git branches
    },
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore session",
      },
      {
        "<leader>qS",
        function()
          require("persistence").select()
        end,
        desc = "Select session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore last session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Stop session save",
      },
    },
  },
}
