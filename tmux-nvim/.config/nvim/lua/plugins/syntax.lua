return {
  -- 1. THE COLORSCHEME (Tokyo Night)
  -- A high-quality theme that supports all your plugins (Noice, Trouble, etc.)
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon", -- 'storm', 'moon', 'night', 'day'
      transparent = true, -- Great for Termux transparency
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- 2. COLOR HIGHLIGHTER (nvim-colorizer)
  -- Shows actual colors behind hex codes (e.g., #ff0000)
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      filetypes = { "*", "!lazy" },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background", -- 'foreground', 'background'
        tailwind = true, -- Support for tailwind colors
      },
    },
  },

  -- 3. INDENT GUIDES (Scope highlighting)
  -- Already handled by Snacks.nvim in your setup, but we can add 
  -- rainbow delimiters here for complex code.
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },

  -- 4. ILLUMINATE (Highlight other instances of word)
  -- This highlights other instances of the variable under your cursor.
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
}
