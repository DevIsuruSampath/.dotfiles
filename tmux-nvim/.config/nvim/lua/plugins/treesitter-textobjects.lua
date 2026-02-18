return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- ENABLED everywhere (Essential for efficient editing)
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end

      ts_configs.setup({
        textobjects = {
          -- 1. SELECT: Select things like functions, classes, arguments
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj
            keymaps = {
              -- Function
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              -- Class
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              -- Arguments (New!)
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              -- Loops / Conditionals
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["ai"] = "@conditional.outer",
              ["ii"] = "@conditional.inner",
            },
          },

          -- 2. MOVE: Jump between functions/classes
          move = {
            enable = true,
            set_jumps = true, -- Add to jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]a"] = "@parameter.inner",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
              ["]A"] = "@parameter.inner",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[a"] = "@parameter.inner",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
              ["[A"] = "@parameter.inner",
            },
          },

          -- 3. SWAP: Swap arguments (Super useful!)
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner", -- Swap with next arg
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner", -- Swap with prev arg
            },
          },
        },
      })
    end,
  },
}
