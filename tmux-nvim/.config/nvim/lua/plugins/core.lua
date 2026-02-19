local is_termux = (vim.env.PREFIX or ""):match("com.termux") ~= nil

return {
  -- 1. PLENARY (Required utility)
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- 2. ICONS
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- 3. TREESITTER (Fixed module loading)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { 
        "bash", "lua", "markdown", "markdown_inline", 
        "vim", "vimdoc", "json", "yaml" , "python"
      },
      auto_install = not is_termux, -- Don't auto-compile on phone to save CPU
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- FIX: Modern way to load Treesitter without calling nvim-treesitter.configs
      -- Most modern versions of Treesitter prefer using the main module or direct setup
      local ok, ts = pcall(require, "nvim-treesitter.configs")
      if ok then
          ts.setup(opts)
      else
          -- Fallback for newer versions where configs might be moved or handled differently
          require("nvim-treesitter").setup(opts)
      end
    end,
  },

  -- 4. TELESCOPE
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    },
    opts = {},
  },

  -- 5. WHICH-KEY
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- 6. GITSIGNS
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- 7. LUALINE
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "auto", globalstatus = true },
    },
  },

  -- 8. TMUX NAVIGATOR
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
}
