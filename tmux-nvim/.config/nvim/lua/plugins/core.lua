local is_termux = (vim.env.PREFIX or ""):match("com.termux") ~= nil

return {
  -- 1. UTILITIES (Required by Telescope and Gitsigns)
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- 2. ICONS (Necessary for Lualine and Telescope UI)
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- 3. SYNTAX HIGHLIGHTING (Treesitter)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- Load on buffer read to ensure immediate highlighting
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- Languages relevant to your web and bot projects
      ensure_installed = { 
        "bash", "lua", "markdown", "markdown_inline", 
        "vim", "vimdoc", "json", "yaml", "python",
        "javascript", "typescript", "tsx", "html", "css" 
      },
      -- Safety for Termux: No auto-compiling in the background
      auto_install = not is_termux, 
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- Fix for module loading errors on newer Neovim versions
      local ok, ts = pcall(require, "nvim-treesitter.configs")
      if ok then
        ts.setup(opts)
      else
        -- Fallback if the .configs module is unavailable
        require("nvim-treesitter").setup(opts)
      end
    end,
  },

  -- 4. FUZZY FINDER (Telescope)
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    },
    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/" },
        path_display = { "truncate" },
      },
    },
  },

  -- 5. KEYBINDING HELPER (Which-Key)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>x", group = "diagnostics/trouble" },
      },
    },
  },

  -- 6. GIT SIGNS (Gutter integration)
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
      },
    },
  },

  -- 7. STATUS LINE (Lualine)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { 
        theme = "tokyonight", -- Matches your syntax.lua theme
        globalstatus = true,
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  -- 8. NAVIGATION (Tmux integration)
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
}
