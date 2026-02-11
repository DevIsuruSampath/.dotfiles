local is_termux = (vim.env.PREFIX or ""):match("com.termux") ~= nil

return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = is_termux and nil or ":TSUpdate",
    opts = {
      ensure_installed = is_termux and {} or { "bash", "lua", "markdown", "markdown_inline", "vim", "vimdoc", "json", "yaml" },
      auto_install = not is_termux,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      local ok, ts = pcall(require, "nvim-treesitter.configs")
      if ok then
        ts.setup(opts)
      end
    end,
  },
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
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "auto", globalstatus = true },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
}
