local is_termux = (vim.env.PREFIX or ""):match("com.termux") ~= nil

return {
  -- 1. UTILITY FUNCTIONS (Required by many plugins)
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- 2. ICONS (Must load early for UI plugins)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- 3. SYNTAX HIGHLIGHTING (Treesitter)
  {
    "nvim-treesitter/nvim-treesitter",
    -- ENABLED on Termux now (essential for highlighting)
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts = {
      ensure_installed = { 
        "bash", "lua", "markdown", "markdown_inline", 
        "vim", "vimdoc", "json", "yaml", "query" 
      },
      -- Disable auto_install on Termux to prevent freezing/compiler errors
      auto_install = not is_termux,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- 4. FUZZY FINDER (Telescope)
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        file_ignore_patterns = { "node_modules", ".git" },
      },
    },
  },

  -- 5. KEY BINDING HELPER
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- Customizing icons/presets for better visuals
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
    },
  },

  -- 6. GIT INTEGRATION
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },

  -- 7. STATUS LINE
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { 
        theme = "auto", 
        globalstatus = true,
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { 'filename', 'branch' },
        lualine_c = { 'fileformat' },
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
      },
    },
  },

  -- 8. TMUX NAVIGATION
  {
    "christoomey/vim-tmux-navigator",
    lazy = false, -- Must load immediately to work with Tmux keybindings
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
