return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- 1. UTILITIES
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      input = { enabled = true },
      
      -- 2. UI ELEMENTS
      statuscolumn = { enabled = true },
      indent = { enabled = true },
      words = { enabled = true },
      
      -- 3. MODULES
      picker = { enabled = true },
      -- ENABLED: This allows Snacks to handle the dashboard if alpha-nvim is not used
      dashboard = { 
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
      
      -- 4. CONFLICT HANDLING
      notifier = { enabled = false }, -- Keep disabled as you use nvim-notify
      scroll = { enabled = false },   -- Keep disabled for Termux performance
    },
    keys = {
      -- PICKER (File Finding)
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep Search" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },

      -- GIT UTILITIES
      { "<leader>gB", function() Snacks.gitblame.line_at_cursor() end, desc = "Git Blame" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },

      -- MOBILE OPTIMIZED UTILS
      { "<leader>z",  function() Snacks.zen.zoom() end, desc = "Zoom Window" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>rf", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss Notify" },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup Toggles
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.inlay_hints():map("<leader>uh")
        end,
      })
    end,
  },
}
