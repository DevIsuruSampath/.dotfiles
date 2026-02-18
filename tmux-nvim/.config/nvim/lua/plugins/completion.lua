return {
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp", -- Optional: install regex support if possible
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ls = require("luasnip")

      -- FIX: This configuration is required for jumping to work correctly
      ls.config.set_config({
        history = true, -- Keep around last snippet local to jump back
        updateevents = "TextChanged,TextChangedI", -- Update changes as you type
        enable_autosnippets = true,
      })

      -- Load VSCode-style snippets (from friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Helper function for Tab completion
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        -- FIX: Add borders to make the menu distinct
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        -- FIX: Add icons/formatting to the menu
        formatting = {
          format = function(entry, item)
            local icons = {
              Text = "", Method = "󰆧", Function = "󰊕", Constructor = "",
              Field = "󰇽", Variable = "󰂡", Class = "󰠱", Interface = "",
              Module = "", Property = "󰜢", Unit = "", Value = "󰎠",
              Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
              File = "󰈙", Reference = "", Folder = "󰉋", EnumMember = "",
              Constant = "󰏿", Struct = "", Event = "", Operator = "󰆕",
              TypeParameter = "󰅲",
            }
            item.kind = string.format("%s %s", icons[item.kind] or "", item.kind)
            item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            })[entry.source.name]
            return item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({ select = true }), 

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
