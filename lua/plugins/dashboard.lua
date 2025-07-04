return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = {
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Neotree source=filesystem reveal=true position=current',
            key = 'f',
          },
        },
      },
    },
    config = function(_,opts)
      require('dashboard').setup(opts)
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
}
