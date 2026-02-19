return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- FIX: Only show dashboard if Neovim is opened without a file
      if vim.fn.argc() > 0 or vim.fn.line2byte("$") ~= -1 or vim.o.insertmode then
        return
      end

      -- HEADER
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

      -- BUTTONS
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
        dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", "󰊄  Live Grep", ":Telescope live_grep <CR>"),
        dashboard.button("s", "  Restore Session", ":lua require('persistence').load() <CR>"),
        dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
      }

      -- FOOTER
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      dashboard.section.footer.val = "⚡ " .. stats.count .. " plugins loaded in " .. ms .. "ms"

      alpha.setup(dashboard.config)

      -- FIX: Ensure UI elements like statusline don't mess up the look on mobile
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          vim.opt.laststatus = 0
          vim.opt.showtabline = 0
          vim.api.nvim_create_autocmd("BufUnload", {
            buffer = 0,
            callback = function()
              vim.opt.laststatus = 3
              vim.opt.showtabline = 2
            end,
          })
        end,
      })
    end,
  },
}
