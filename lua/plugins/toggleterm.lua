return {
  {
    -- amongst your other plugins
    { 'akinsho/toggleterm.nvim', version = '*', config = true },
    -- or
    {
      'akinsho/toggleterm.nvim',
      version = '*',
      opts = {
        float_opts = {
          title_pos = 'center',
          border = 'double',
        },
        FloatBorder = {
        guibg = "Black",
        guifg = "Black",
        },
      },
    },
  },
}
