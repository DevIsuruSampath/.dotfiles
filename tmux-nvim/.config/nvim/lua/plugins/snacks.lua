return {
  {
    "folke/snacks.nvim",
    priority = 1000, -- Load early to handle big files/notifications
    lazy = false,
    opts = {
      -- 1. UTILITIES
      bigfile = { enabled = true }, -- Prevents freezing on large files
      quickfile = { enabled = true }, -- Speeds up opening files without plugins
      input = { enabled = true }, -- Better UI for "Rename" and input prompts
      
      -- 2. UI ELEMENTS
      statuscolumn = { enabled = true }, -- Shows git signs/folds in the gutter
      indent = { enabled = true }, -- Indent guides (replaces indent-blankline)
      words = { enabled = true }, -- Highlights other usages of the word under cursor
      
      -- 3. MODULES
      picker = { enabled = true }, -- The new Snacks Picker (Fast!)
      dashboard = { enabled = false }, -- Disabled as requested (saves startup time)
      
      -- 4. CONFLICT HANDLING
      -- Disabled because you are using 'rcarriga/nvim-notify' in noice.lua
      notifier = { enabled = false }, 
      scroll = { enabled = false }, -- Disabled to save battery/performance on mobile
    },
    keys = {
      -- PICKER (File Finding)
      { 
        "<leader><space>", 
        function() Snacks.picker.smart() end, 
        desc = "Find Files (Smart)" 
      },
      { 
        "<leader>/", 
        function() Snacks.picker.grep() end, 
        desc = "Grep (Search Text)" 
      },
      { 
        "<leader>fb", 
        function() Snacks.picker.buffers() end, 
        desc = "Find Buffers" 
      },

      -- GIT UTILITIES
      { 
        "<leader>gB", 
        function() Snacks.gitblame.line_at_cursor() end, 
        desc = "Git Blame Line" 
      },
      { 
        "<leader>gf", 
        function() Snacks.lazygit.log_file() end, 
        desc = "Lazygit Current File History" 
      },

      -- OTHER UTILITIES (Crucial for Mobile)
      { 
        "<leader>z", 
        function() Snacks.zen.zoom() end, 
        desc = "Toggle Zoom (Maximize Window)" 
      },
      { 
        "<leader>bd", 
        function() Snacks.bufdelete() end, 
        desc = "Delete Buffer" 
      },
      { 
        "<leader>rf", 
        function() Snacks.rename.rename_file() end, 
        desc = "Rename File" 
      },
    },
    init = function()
      -- Create the global Snacks object + Toggle mappings
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Add a toggle for the word highlighter
          Snacks.toggle.words():map("<leader>uw")
        end,
      })
    end,
  },
}
