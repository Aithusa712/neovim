return {
  {
    'Vigemus/iron.nvim',
    lazy = true, -- Load the plugin only when needed
    ft = { -- File types that will trigger loading of the plugin
      'python',
      'lua',
      'r',
      'julia',
      'scheme',
      'lisp',
      'sh',
      'javascript',
      'typescript',
    },

    config = function()
      local view = require 'iron.view'
      local common = require 'iron.fts.common'
      require('iron.core').setup {
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { 'zsh' },
            },
            python = {
              command = { 'ipython', '--no-autoindent' }, -- or { 'python3'}, 
              format = common.bracketed_paste,
              block_dividers = { '# %%', '#%%' },
            },
          },
          repl_filetype = function(bufnr, ft)
            return ft
          end,

          repl_open_cmd = view.right(70),
        },
        keymaps = {
          toggle_repl = '<space>rr', -- toggles the repl open and closed.
          restart_repl = '<space>rR', -- calls `IronRestart` to restart the repl
          visual_send = '<space>rv',
          send_line = '<space>rl',
          send_code_block = '<space>rb',
          cr = '<space>r<cr>',
          exit = '<space>rq',
          clear = '<space>rc',
        },
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }
      vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
      vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
    end,
  },
}
