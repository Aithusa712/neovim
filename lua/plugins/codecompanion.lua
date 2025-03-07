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
          adapter = 'openai',
        },
        inline = {
          adapter = 'openai',
        },
      },
      adapters = {
        openai = function()
          return require('codecompanion.adapters').extend('openai', {
            name = 'gpt-4o-mini',
            schema = {
              model = {
                default = 'gpt-4o-mini',
              },
            },
            env = {
              api_key = 'cmd: gpg --batch --quiet --decrypt /home/kim/keys/openai_key.asc',
            },
          })
        end,
      },
    }
  end,
}
