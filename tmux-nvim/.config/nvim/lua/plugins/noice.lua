-- Removed the Termux check so plugins are ALWAYS enabled
return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        -- override markdown rendering so that cmp and other plugins use Treesitter
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- Presets help configure Noice for common setups
      presets = {
        bottom_search = false,        -- Set to FALSE to move search to center (optional)
        command_palette = true,       -- TRUE: position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    -- Removed "enabled = not is_termux" here too
    opts = {
      timeout = 3000,
      background_colour = "#000000",
      render = "minimal", -- 'minimal' or 'simple' is better for Termux than 'default'
      stages = "static",  -- 'static' removes animation to prevent lag on phone
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },
}
