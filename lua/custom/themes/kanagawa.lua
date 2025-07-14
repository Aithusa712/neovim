-- plugins.lua (or wherever you configure lazy.nvim)
return {
  -- Kanagawa color theme
  {
    "rebelot/kanagawa.nvim",
    priority = 1000, -- Load early so it's applied before other plugins/themes
    config = function()
      -- Set up the theme (see repo for all options)
      require('kanagawa').setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
       theme = "wave",  -- Load "wave" theme 
        background = {   -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "lotus"
        },
      }) -- Load the colorscheme
      vim.cmd([[colorscheme kanagawa]])
    end
  },

}
