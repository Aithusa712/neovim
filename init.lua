require 'settings.options'
require 'settings.keymaps'

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
  require 'custom.plugins.debug',
  require 'custom.plugins.indent_line',
  require 'custom.plugins.lint',
  require 'custom.plugins.autopairs',
  require 'custom.plugins.neo-tree',
  require 'custom.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE:  THEMES

  --require 'custom.themes.dracula',
  require 'custom.themes.tokyonight',
  -- require 'custom.themes.kanagawa',
  -- require 'custom.themes.onedark',
  -- vim.cmd("colorscheme unokai"),
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
