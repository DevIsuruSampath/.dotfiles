return {
  -- 1. FILE MANAGER (Oil.nvim)
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Icons support
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      default_file_explorer = true, -- Replaces the default Netrw file browser
      delete_to_trash = false,      -- Set to true if you have a trash utility installed
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == ".." or name == ".git"
        end,
      },
      -- Optional: Float window configuration if you prefer floating mode
      float = {
        padding = 2,
        max_width = 90,
        max_height = 0,
      },
    },
  },

  -- 2. COMMENTING
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- Load immediately when opening a file
    opts = {
      padding = true,
      sticky = true,
      ignore = "^$", -- Ignore empty lines
      mappings = {
        basic = true,
        extra = true, -- Enable extra mappings like gco, gcO, gcA
      },
    },
  },

  -- 3. SURROUND (ysiw", ds", cs"')
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  
  -- 4. AUTOPAIRS (Auto close brackets/quotes)
  -- Added this as it's essential for "editing"
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- Enable treesitter integration
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
    },
  },
}
