return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- 1. UI & DASHBOARD
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { 
            section = "terminal", 
            cmd = "echo 'ADSEXAMPLE.COM PROJECT | URL SHORTENER | TELEGRAM BOT'", 
            hl = "Keyword", 
            padding = 1, 
            indent = 8 
          },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
        -- Custom Header for your branding
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
      -- 2. CORE UTILITIES
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      input = { enabled = true },
      statuscolumn = { enabled = true },
      indent = { enabled = true },
      words = { enabled = true },
      picker = { enabled = true },
      
      -- 3. DISABLE CONFLICTS
      notifier = { enabled = false }, -- Using nvim-notify
      scroll = { enabled = false },   -- Save battery on Termux
    },
    keys = {
      -- PICKER MAPPINGS
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep Search" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },

      -- WORKFLOW & GIT
      { "<leader>z",  function() Snacks.zen.zoom() end, desc = "Zoom Window" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>rf", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      
      -- DASHBOARD MANUAL OPEN
      { "<leader>ud", function() Snacks.dashboard.open() end, desc = "Open Dashboard" },
    },
    -- 4. FORCE LOAD LOGIC (Crucial for Neovim 0.11)
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Only open if Neovim started with no arguments and buffer is empty
          if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" then
            require("snacks").dashboard.open()
          end
          
          -- Global Toggles
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.line_number():map("<leader>ul")
        end,
      })
    end,
  },
}
