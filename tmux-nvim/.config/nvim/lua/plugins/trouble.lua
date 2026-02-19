return {
  {
    "folke/trouble.nvim",
    -- Updated commands for Trouble v3
    cmd = { "Trouble" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      auto_close = true, -- Close trouble list when you open a file
      restore_prev_win = true,
      modes = {
        -- Customizing the lsp mode for better focus
        lsp = {
          win = { position = "right", size = 0.3 },
        },
      },
    },
    keys = {
      -- 1. Diagnostics (The main use case)
      { 
        "<leader>xx", 
        "<cmd>Trouble diagnostics toggle<cr>", 
        desc = "Diagnostics (Project)" 
      },
      { 
        "<leader>xX", 
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", 
        desc = "Diagnostics (File)" 
      },

      -- 2. Symbols & LSP
      { 
        "<leader>cs", 
        "<cmd>Trouble symbols toggle focus=false<cr>", 
        desc = "Symbols (Trouble)" 
      },
      { 
        "<leader>xl", 
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", 
        desc = "LSP Definitions/References" 
      },

      -- 3. Lists
      { 
        "<leader>xL", 
        "<cmd>Trouble loclist toggle<cr>", 
        desc = "Location List" 
      },
      { 
        "<leader>xq", 
        "<cmd>Trouble qflist toggle<cr>", 
        desc = "Quickfix List" 
      },

      -- 4. Clean up
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, _ = pcall(vim.cmd.cprev)
            if not ok then vim.cmd.lprev() end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, _ = pcall(vim.cmd.cnext)
            if not ok then vim.cmd.lnext() end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },
}
