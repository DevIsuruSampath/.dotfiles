return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { 
            section = "terminal", 
            cmd = "echo 'ACTIVE: ADSEXAMPLE.COM | URL SHORTENER | TELEGRAM BOT'", 
            hl = "Keyword", padding = 1, indent = 4 
          },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
        preset = {
          header = [[
   █████╗ ██████╗ ███████╗███████╗██╗  ██╗ █████╗ ███╗   ███╗██████╗ ██╗     ███████╗
  ██╔══██╗██╔══██╗██╔════╝██╔════╝╚██╗██╔╝██╔══██╗████╗ ████║██╔══██╗██║     ██╔════╝
  ███████║██║  ██║███████╗█████╗   ╚███╔╝ ███████║██╔████╔██║██████╔╝██║     █████╗  
  ██╔══██║██║  ██║╚════██║██╔══╝   ██╔██╗ ██╔══██║██║╚██╔╝██║██╔═══╝ ██║     ██╔══╝  
  ██║  ██║██████╔╝███████║███████╗██╔╝ ██╗██║  ██║██║ ╚═╝ ██║██║     ███████╗███████╗
  ╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝     ╚══════╝╚══════╝
          ]],
        },
      },
      bigfile = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false }, -- Stay disabled for Termux
      words = { enabled = true },
    },
    keys = {
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>z",  function() Snacks.zen.zoom() end, desc = "Zoom" },
    },
    init = function()
      -- CRITICAL FIX FOR v0.11.6:
      -- We hide the main UI until Snacks is ready to draw the dashboard
      vim.api.nvim_create_autocmd("UIEnter", {
        once = true,
        callback = function()
          if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" then
            vim.schedule(function()
              require("snacks").dashboard.open()
            end)
          end
        end,
      })
    end,
  },
}
