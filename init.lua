-- NOTE: [[ Leader Key ]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true -- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.indent_blankline_filetype_exclude = { 'dashboard' }
-- NOTE: [[ Setting options ]]

-- See `:help vim.opt`
-- See`:help option-list`

-- vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true -- You can also add relative line numbers, to help with jumping.
vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
vim.opt.clipboard = 'unnamedplus' --  See `:help 'clipboard'`
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
-- Decrease mapped sequence wait time
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

-- Set the background color for the cursor line
vim.cmd [[highlight CursorLine cterm=NONE ctermbg=darkgrey guibg=lightgrey]]
-- NOTE: [[ Basic Keymaps ]]

--  See `:help vim.keymap.set()`
vim.keymap.set('n', '<leader>tn', '<cmd>Telescope colorscheme<CR>', { desc = 'Open colorschemes' })
vim.keymap.set('n', '<leader>nr', '<cmd>setl rnu!<CR>', { desc = 'Set Relative Number Line' })
vim.keymap.set('n', '<leader>nl', '<cmd>setl nu!<CR>', { desc = 'Set Number Line' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' }) -- Diagnostic keymaps
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }) -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set('n', '<C-,>', '<cmd>bprev<CR>') -- Go to prev buffer
vim.keymap.set('n', '<C-.>', '<cmd>bnext<CR>') -- Go to next buffer
vim.keymap.set('n', '<C-/>', '<cmd>bd<CR>')
vim.keymap.set('n', '<A-t>', '<cmd>terminal<CR>') --open terminal
-- Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>') vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
-- Keybinds to make split navigation easier. Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- NOTE: [[ Install `lazy.nvim` plugin manager ]]

--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- NOTE: PLUGINS

require('lazy').setup({
  'tpope/vim-sleuth',
  -- require 'custom.plugins.debug',
  require 'custom.plugins.indent_line',
  require 'custom.plugins.lint',

  require 'custom.plugins.autopairs',
  require 'custom.plugins.neo-tree',
  require 'custom.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE:  THEMES

  --require 'custom.themes.dracula',
  require 'custom.themes.tokyonight',

  { import = 'plugins' }, -- import from plugin folder
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
