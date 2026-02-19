[span_0](start_span)local is_termux = (vim.env.PREFIX or ""):match("com.termux") ~= nil[span_0](end_span)

return {
  -- 1. PLENARY (Required utility for Telescope and Gitsigns)
  {
    "nvim-lua/plenary.nvim",
    [span_1](start_span)lazy = true,[span_1](end_span)
  },

  -- 2. ICONS (Necessary for UI plugins)
  {
    "nvim-tree/nvim-web-devicons",
    [span_2](start_span)lazy = true,[span_2](end_span)
  },

  -- 3. TREESITTER (Syntax Highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    [span_3](start_span)build = ":TSUpdate",[span_3](end_span)
    [span_4](start_span)event = { "BufReadPost", "BufNewFile" },[span_4](end_span)
    opts = {
      ensure_installed = { 
        "bash", "lua", "markdown", "markdown_inline", 
        "vim", "vimdoc", "json", "yaml", "python",
        "javascript", "typescript", "tsx", "html", "css" 
      [span_5](start_span)},[span_5](end_span)
      [span_6](start_span)auto_install = not is_termux,[span_6](end_span)
      [span_7](start_span)highlight = { enable = true },[span_7](end_span)
      [span_8](start_span)indent = { enable = true },[span_8](end_span)
    },
    config = function(_, opts)
      -- FIX: Protected call to prevent crashes if the module structure changed
      local ok, ts = pcall(require, "nvim-treesitter.configs")
      if ok then
        [span_9](start_span)ts.setup(opts)[span_9](end_span)
      else
        -- Fallback for newer TS versions
        [span_10](start_span)require("nvim-treesitter").setup(opts)[span_10](end_span)
      end
    [span_11](start_span)end,[span_11](end_span)
  },

  -- 4. TELESCOPE (Fuzzy Finder)
  {
    "nvim-telescope/telescope.nvim",
    [span_12](start_span)cmd = "Telescope",[span_12](end_span)
    [span_13](start_span)dependencies = { "nvim-lua/plenary.nvim" },[span_13](end_span)
    keys = {
      [span_14](start_span){ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },[span_14](end_span)
      [span_15](start_span){ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },[span_15](end_span)
      [span_16](start_span){ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },[span_16](end_span)
      [span_17](start_span){ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },[span_17](end_span)
    },
    opts = {
      defaults = {
        [span_18](start_span)file_ignore_patterns = { "node_modules", ".git/" },[span_18](end_span)
        [span_19](start_span)path_display = { "truncate" },[span_19](end_span)
      },
    },
  },

  -- 5. WHICH-KEY (Keybinding helper)
  {
    "folke/which-key.nvim",
    [span_20](start_span)event = "VeryLazy",[span_20](end_span)
    opts = {
      [span_21](start_span)preset = "modern",[span_21](end_span)
      spec = {
        [span_22](start_span){ "<leader>f", group = "file/find" },[span_22](end_span)
        [span_23](start_span){ "<leader>g", group = "git" },[span_23](end_span)
        [span_24](start_span){ "<leader>x", group = "diagnostics/trouble" },[span_24](end_span)
      },
    },
  },

  -- 6. GITSIGNS (Git integration in gutter)
  {
    "lewis6991/gitsigns.nvim",
    [span_25](start_span)event = { "BufReadPre", "BufNewFile" },[span_25](end_span)
    opts = {
      signs = {
        [span_26](start_span)add = { text = "▎" },[span_26](end_span)
        [span_27](start_span)change = { text = "▎" },[span_27](end_span)
        [span_28](start_span)delete = { text = "" },[span_28](end_span)
      },
    },
  },

  -- 7. LUALINE (Status line)
  {
    "nvim-lualine/lualine.nvim",
    [span_29](start_span)event = "VeryLazy",[span_29](end_span)
    [span_30](start_span)dependencies = { "nvim-tree/nvim-web-devicons" },[span_30](end_span)
    opts = {
      options = { 
        theme = "tokyonight", 
        [span_31](start_span)globalstatus = true,[span_31](end_span)
        [span_32](start_span)component_separators = "|",[span_32](end_span)
        [span_33](start_span)section_separators = "",[span_33](end_span)
      },
    },
  },

  -- 8. NAVIGATION (Seamless movement)
  {
    "christoomey/vim-tmux-navigator",
    [span_34](start_span)lazy = false,[span_34](end_span)
  },
}
