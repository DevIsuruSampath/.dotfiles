local is_termux = (vim.env.PREFIX or ""):match("com.termux") ~= nil

return {
  -- 1. MASON (Package Manager)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },

  -- 2. MASON-LSPCONFIG (Bridges Mason and LSP)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- On Termux, we often install manually to avoid build issues,
      -- but this list works if packages are compatible.
      ensure_installed = is_termux and {} or {
        "lua_ls",
        "bashls",
        "jsonls",
        "yamlls",
      },
      automatic_installation = not is_termux,
    },
  },

  -- 3. LSPCONFIG (The Core Configuration)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- Required for autocompletion capabilities
    },
    config = function()
      -- A. Setup Diagnostic Signs (The icons in the sidebar)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- B. Setup Capabilities (Connects to nvim-cmp)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      -- C. The Setup Function (Compatible with Neovim 0.11+)
      local function setup_server(server_name)
        -- 1. Get the default config from nvim-lspconfig
        local ok_conf, configs = pcall(require, "lspconfig.configs")
        if not ok_conf or not configs[server_name] then return end

        local defaults = configs[server_name].default_config or {}

        -- 2. Prepare custom settings (Specific fix for Lua "vim" global)
        local settings = {}
        if server_name == "lua_ls" then
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          }
        end

        -- 3. Merge defaults + capabilities + settings
        local final_opts = vim.tbl_deep_extend("force", defaults, {
          capabilities = capabilities,
          settings = settings,
        })

        -- 4. Assign to vim.lsp.config (The New Way)
        -- This registers the server and auto-starts it on file open
        vim.lsp.config[server_name] = final_opts
      end

      -- D. Iterate and Setup Servers
      local ok_mason, mason_lsp = pcall(require, "mason-lspconfig")
      if ok_mason and type(mason_lsp.setup_handlers) == "function" then
        -- Use Mason to setup installed servers
        mason_lsp.setup_handlers({
          function(server)
            setup_server(server)
          end,
        })
      else
        -- Fallback: Manual setup if Mason is missing/failing
        local manual_servers = { "lua_ls", "bashls", "jsonls", "yamlls" }
        for _, server in ipairs(manual_servers) do
          setup_server(server)
        end
      end

      -- E. Keymaps (LspAttach Autocommand)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
          end

          map("gd", vim.lsp.buf.definition, "LSP: go to definition")
          map("gr", vim.lsp.buf.references, "LSP: references")
          map("K", vim.lsp.buf.hover, "LSP: hover")
          map("<leader>rn", vim.lsp.buf.rename, "LSP: rename")
          map("<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
          map("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
          map("]d", vim.diagnostic.goto_next, "Go to next diagnostic")
        end,
      })
    end,
  },
}
