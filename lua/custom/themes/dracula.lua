return {
  'Mofiqul/dracula.nvim',
  name = 'dracula',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'dracula'

    -- You can configure highlights by doing something like:
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
}
