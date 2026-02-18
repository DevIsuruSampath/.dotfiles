return {
  -- 1. DIFFVIEW (Advanced Git Diff/Merge tool)
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diff View" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Current File History" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Project File History" },
    },
    opts = {
      enhanced_diff_hl = true, -- Better highlighting
      view = {
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true,
        },
      },
    },
  },

  -- 2. LAZYGIT (Terminal Git Client Wrapper)
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
    },
    config = function()
      -- Configuration for the floating window
      vim.g.lazygit_floating_window_winblend = 0 -- 0 = Opaque (better for reading on mobile)
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- Scale to 90% of screen
      vim.g.lazygit_floating_window_border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
      vim.g.lazygit_use_neovim_remote = 1 -- Fallback to nvim-remote if available
    end,
  },
}
