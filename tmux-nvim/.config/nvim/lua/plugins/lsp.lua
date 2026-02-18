local is_termux = (vim.env.PREFIX or ""):match("com.termux") ~= nil

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = is_termux and {} or {
        "lua_ls",
        "bashls",
        "jsonls",
        "yamlls",
      },
      automatic_installation = not is_termux,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- Required for capabilities
    },
    config = function()
      -- 1. Setup Capabilities (Auto-completion support)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      -- 2. Define the new setup function for Neovim 0.11+
      local function setup_server(server_name)
        -- We get the default config (cmd, filetypes) from nvim-lspconfig
        local ok_config, configs = pcall(require, "lspconfig.configs")
        if not ok_config or not configs[server_name] then return end

        local defaults = configs[server_name].default_config or {}
        
        -- Merge defaults with our custom capabilities
        local final_opts = vim.tbl_deep_extend("force", defaults, {
          capabilities = capabilities,
        })

        -- THE FIX: Assign to vim.lsp.config instead of calling .setup()
        vim.lsp.config[server_name] = final_opts
        vim.lsp.enable(server_name)
      end

      -- 3. Integrate with Mason
      local ok_mason, mason_lsp = pcall(require, "mason-lspconfig")
      if ok_mason and type(mason_lsp.setup_handlers) == "function" then
        mason_lsp.setup_handlers({
          function(server)
            setup_server(server)
          end,
        })
      else
        -- Fallback if Mason isn't loading
        for _, server in ipairs({ "lua_ls", "bashls", "jsonls", "yamlls" }) do
          setup_server(server)
        end
      end

      -- 4. Keymaps (LspAttach)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
          end

          map("gd", vim.lsp.buf.definition, "LSP: go to definition")
          map("gr", vim.lsp.buf.references, "LSP: references")
          map("K", vim.lsp.buf.hover, "LSP: hover")
          map("<leader>rn", vim.lsp.buf.rename, "LSP: rename")
          map("<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
        end,
      })
    end,
  },
}
