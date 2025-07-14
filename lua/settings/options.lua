-- NOTE: [[ Leader Key ]]
--Add Syntax highlight for hyprland.config files
vim.filetype.add {
  pattern = { ['.*/hypr/.*%.conf'] = 'hyprlang' },
}

-- vim.opt.tabstop     = 4  -- width of a hard tab character
-- vim.opt.shiftwidth  = 4  -- width used for autoindent
-- vim.opt.expandtab   = true  -- convert tabs to spaces

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true -- Set to true if you have a Nerd Font installed and selected in the terminal
--vim.g.python3_host_prog = '~/.venv/bin/python'

vim.g.indent_blankline_filetype_exclude = { 'dashboard' }
-- NOTE: [[ Setting options ]]
-- 	See `:help vim.opt`
-- 	See`:help option-list`
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true -- You can also add relative line numbers, to help with jumping.
vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.clipboard = 'unnamedplus' --  See `:help 'clipboard'`
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
vim.opt.splitright = true -- Configure how new splits should be opened
vim.opt.splitbelow = true
-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true --  See `:help 'list'`
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } --  and `:help 'listchars'`
vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.hlsearch = true
vim.opt.termguicolors = true
vim.opt.cursorlineopt = 'both' --screenline
vim.opt.cmdheight = 1

--NOTE: [[ Basic Autocommands ]]

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Set up an autocmd to trigger LSP hover on CursorHold

vim.diagnostic.config { virtual_lines = false }
vim.diagnostic.config { virtual_text = false }
