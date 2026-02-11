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
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      local ok_mason, mason_lsp = pcall(require, "mason-lspconfig")
      local function setup_server(server)
        if lspconfig[server] then
          lspconfig[server].setup({ capabilities = capabilities })
        end
      end

      if ok_mason and type(mason_lsp.setup_handlers) == "function" then
        mason_lsp.setup_handlers({
          function(server)
            setup_server(server)
          end,
        })
      else
        for _, server in ipairs({ "lua_ls", "bashls", "jsonls", "yamlls" }) do
          setup_server(server)
        end
      end

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
