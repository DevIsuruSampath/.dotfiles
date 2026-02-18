return {
  -- 1. FORMATTING (Conform.nvim)
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- Load early to ready commands
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>mp",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      notify_on_error = true,
      -- Define formatters
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        -- Use Prettier for web/config files
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        -- Fallback to sub-formatters if one is missing
        ["_"] = { "trim_whitespace" },
      },
      -- Format on Save logic
      format_on_save = function(bufnr)
        -- Disable auto-format for specific filetypes if needed
        local disable_filetypes = { c = true, cpp = true }
        local ft = vim.bo[bufnr].filetype
        
        if disable_filetypes[ft] then
           return
        end

        return {
          timeout_ms = 3000, -- Increased from 500ms to allow Prettier to run
          lsp_format = "fallback", -- Use LSP if no formatter is available
        }
      end,
    },
  },

  -- 2. LINTING (Nvim-lint)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        zsh = { "shellcheck" },
        markdown = { "markdownlint" },
        yaml = { "yamllint" },
        json = { "jsonlint" },
      }

      -- Create autocommand to trigger linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
        group = lint_augroup,
        callback = function()
          -- Only lint if the buffer is a normal file
          if vim.bo.buftype == "" then
             lint.try_lint()
          end
        end,
      })
    end,
  },
}
