return {
  -- 1. HARPOON (Fast file switching)
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: Add File" })
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Menu" })

      -- Quick Jump to files 1-4
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon to 1" })
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon to 2" })
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon to 3" })
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon to 4" })
      
      -- Toggle previous & next buffers in list
      vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon: Prev" })
      vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon: Next" })
    end,
  },

  -- 2. TODO COMMENTS (Highlight & Search TODO, FIXME, etc.)
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true, -- show icons in the gutter
      highlight = {
        multiline = true,
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide"
        after = "fg", -- "fg" or "bg" or empty
      },
    },
    keys = {
      -- Navigation between TODOs
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
      
      -- Searching TODOs
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search TODOs (Telescope)" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" },
      { "<leader>xq", "<cmd>TodoQuickfix<cr>", desc = "TODOs (Quickfix)" },
    },
  },
}
