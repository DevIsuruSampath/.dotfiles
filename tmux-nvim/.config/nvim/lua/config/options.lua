vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- 1. LINE NUMBERS
opt.number = true
opt.relativenumber = true

-- 2. MOUSE & CLIPBOARD
opt.mouse = "a"
local is_termux = (vim.env.PREFIX or ""):match("com.termux") ~= nil

-- Better Clipboard handling for Termux
if is_termux then
  -- In Termux, we often need to use the system clipboard via termux-clipboard-set/get
  vim.g.clipboard = {
    name = "termux",
    copy = { ["+"] = "termux-clipboard-set", ["*"] = "termux-clipboard-set" },
    paste = { ["+"] = "termux-clipboard-get", ["*"] = "termux-clipboard-get" },
    cache_enabled = 0,
  }
else
  opt.clipboard = "unnamedplus"
end

-- 3. TABS & INDENTATION (The most common missing part)
opt.tabstop = 2         -- Number of spaces a tab counts for
opt.shiftwidth = 2      -- Number of spaces for auto-indent
opt.expandtab = true    -- Convert tabs to spaces
opt.smartindent = true  -- Insert indents automatically
opt.breakindent = true

-- 4. SEARCH BEHAVIOR
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true     -- Highlight all matches of previous search
opt.incsearch = true    -- Show matches while typing
opt.inccommand = "split" -- Preview substitutions in a split window

-- 5. PERFORMANCE & UI
opt.updatetime = 250    -- Faster completion and diagnostic updates
opt.timeoutlen = 300    -- Faster which-key response
opt.signcolumn = "yes"  -- Always show the gutter to prevent "jumping" text
opt.cursorline = true   -- Highlight the current line
opt.termguicolors = true -- Enable 24-bit RGB colors (Required for TokyoNight)
opt.scrolloff = 8       -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8   -- Keep 8 columns to the left/right

-- 6. WINDOW SPLITS
opt.splitright = true
opt.splitbelow = true

-- 7. FILES & BACKUPS
opt.undofile = true     -- Persistent undo history
opt.swapfile = false    -- Disable swap files (managed by Git/Undo)
opt.backup = false      -- Disable backup files
opt.writebackup = false

-- 8. VISUAL HELPERS
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { eob = " " } -- Hide the '~' on empty lines at end of buffer

-- 9. WRAP & FORMATTING
opt.wrap = false        -- Don't wrap lines by default
