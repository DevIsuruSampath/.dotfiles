return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- 1. HEADER (ASCII ART)
      -- Using a small logo that fits on mobile/Termux screens
      dashboard.section.header.val = {
        [[                                  ]],
        [[    ███╗   ██╗██╗   ██╗██╗███╗   ███╗ ]],
        [[    ████╗  ██║██║   ██║██║████╗ ████║ ]],
        [[    ██╔██╗ ██║██║   ██║██║██╔████╔██║ ]],
        [[    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        [[                                  ]],
      }

      -- 2. BUTTONS
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
        dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", "󰊄  Live Grep", ":Telescope live_grep <CR>"),
        dashboard.button("s", "  Restore Session", ":lua require('persistence').load() <CR>"),
        dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
      }

      -- 3. FOOTER (Plugin stats)
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"

      -- 4. APPLY THEME
      -- Adding layout padding so it doesn't look cramped on your phone
      dashboard.config.opts.noautocmd = true
      alpha.setup(dashboard.config)

      -- Disable folding on the dashboard
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function()
          vim.opt_local.laststatus = 0
          vim.opt_local.showtabline = 0
        end,
      })
    end,
  },
}
