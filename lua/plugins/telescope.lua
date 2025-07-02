return {

  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },

  opts = {
    defaults = {
      layout_strategy = 'vertical',
      layout_config = {
        bottom_pane = {
          height = 5,
          preview_cutoff = 120,
          prompt_position = 'top',
        },
        center = {
          height = 0.4,
          preview_cutoff = 40,
          prompt_position = 'top',
          width = 0.5,
        },
        cursor = {
          height = 0.9,
          preview_cutoff = 40,
          width = 0.8,
        },
        horizontal = {
          height = 0.9,
          preview_cutoff = 120,
          prompt_position = 'bottom',
          width = 0.8,
        },
        vertical = {
          height = 0.9,
          preview_cutoff = 40,
          prompt_position = 'bottom',
          width = 0.8,
        },
      },
    },
    pickers = {
      buffers = {
        theme = 'ivy',
        initial_mode = 'normal',
        layout_config = {
          bottom_pane = {
            height = 10,
            preview_cutoff = 40,
            prompt_position = 'top',
          },
        },
      },
      diagnostics = {
        theme = 'ivy',
        initial_mode = 'normal',
        layout_config = {
          bottom_pane = {
            height = 10,
            preview_cutoff = 20,
            prompt_position = 'top',
          },
        },
      },
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(), --.get_dropdown .get_cursor .get_ivy
      },
    },
  },
  config = function(_, opts)
    require('telescope').setup(opts)
    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>cd', builtin.diagnostics, { desc = '[D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Function keymaps

    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
