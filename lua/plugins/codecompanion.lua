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
        display = {
          action_palette = {
            width = 95,
            height = 10,
            prompt = 'Prompt ', -- Prompt used for interactive LLM calls
            provider = 'telescope', -- telescope|mini_pick|snacks|default
            opts = {
              show_default_actions = true, -- Show the default actions in the action palette?
              show_default_prompt_library = true, -- Show the default prompt library in the action palette?

            },
          },
          chat = {
            -- adapter = 'openai',
          },
          inline = {
            -- adapter = 'openai',
          },
        },
        adapters = {
          -- openai = function()
          --   return require('codecompanion.adapters').extend('openai', {
          --     name = 'gpt-4o-mini',
          --     schema = {
          --       model = {
          --         default = 'gpt-4o-mini',
          --       },
          --     },
          --     env = {
          --       api_key = 'cmd: gpg --batch --quiet --decrypt /home/kim/keys/openai_key.asc',
          --     },
          --   })
          --     end,
        },
      },
    }
  end,
}
