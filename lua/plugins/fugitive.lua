

return {
  'tpope/vim-fugitive',
  cmd = {
    'Git', 'G', 'Gdiffsplit', 'Gread', 'Gwrite', 'Glog',
    'Gedit', 'Ggrep', 'GMove', 'GDelete', 'GBrowse', 'Gvdiffsplit'
  },
  keys = {
    { '<leader>gs', '<cmd>Git<CR>', desc = 'Git status (Fugitive)' },
    { '<leader>gd', '<cmd>Gvdiffsplit<CR>', desc = 'Git diff split' },
    { '<leader>gp', '<cmd>Git push<CR>', desc = 'Git push' },
    { '<leader>gl', '<cmd>Git pull<CR>', desc = 'Git pull' },
  },
  init = function()
    vim.cmd [[
      augroup FugitiveCustom
        autocmd!
        autocmd FileType fugitive setlocal nonumber norelativenumber
      augroup END
    ]]
  end,
}

