return {
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'tokyonight'
      vim.cmd.hi 'Comment gui=none'
    end,
    opts = {
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
      on_highlights = function(hl, c)
        hl.Comment = {
          fg = '#565f89', -- bright green; replace with your preferred hex
          italic = false, -- or true if you want italics
        }
      end,
    },
  },
}
