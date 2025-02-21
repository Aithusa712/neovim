return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } },
  },
  config = function()
    require('codecompanion').setup {
      strategies = {
        chat = {
          adapter = 'anthropic',
        },
        inline = {
          adapter = 'anthropic',
        },
      },
      adapters = {
        anthropic = function()
          return require('codecompanion.adapters').extend('anthropic', {
            env = {
              api_key = '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',
            },
          })
        end,
      },
    }
  end,
}
