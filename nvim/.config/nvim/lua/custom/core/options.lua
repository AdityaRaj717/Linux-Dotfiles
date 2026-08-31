-- [[ Setting options ]]
-- See `:help vim.opt`

vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "no"
vim.opt.completeopt = "menuone,noinsert,noselect"

-- nvim/lua/custom/core/options.lua

-- Custom status column to add spacing
-- %s = Sign column (if enabled)
-- %= = Right align the numbers
-- %{...} = The logic to show relative vs absolute numbers
-- "  " = THE PADDING (Two spaces at the end)
vim.opt.statuscolumn = "%s%=%{v:relnum?v:relnum:v:lnum}   "

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("filetype plugin indent on")

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.cmdheight = 0 -- Makes it cleaner

vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.softtabstop = 2

-- Hide the '~' characters on empty lines at the end of the buffer
-- vim.opt.fillchars:append({ eob = " " })

-- Hide the ruler (e.g., "10,5" position info) in the bottom right
-- (You have lualine for this info, so it's redundant)
vim.opt.ruler = false

-- Don't show the command in the bottom bar (like when you type "d2...")
vim.opt.showcmd = false

-- Use a global statusline (one single line at the bottom instead of one per window)
-- This looks much cleaner with splits
vim.opt.laststatus = 3

-- [[ Folding Options ]]
vim.opt.foldcolumn = "1" -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
