-- debug.lua
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      { '<leader>d1', dap.continue,          desc = 'Debug: Start/Continue' },
      { '<leader>d2', dap.step_into,         desc = 'Debug: Step Into' },
      { '<leader>d3', dap.step_over,         desc = 'Debug: Step Over' },
      { '<leader>d4', dap.step_out,          desc = 'Debug: Step Out' },
      { '<leader>db', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
      {
        '<leader>dB',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
      { '<leader>dt', dapui.toggle, desc = 'Debug: See last session result.' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        --'delve',
        'js-debug-adapter',
      }
    }
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      mappings = {
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
      },
      element_mappings = {},
      expand_lines = vim.fn.has 'nvim-0.7' == 1,
      force_buffers = true,
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.25, -- Can be float or integer > 1
            },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks',      size = 0.25 },
            { id = 'watches',     size = 0.25 },
          },
          size = 40,
          position = 'left', -- Can be "left" or "right"
        },
        {
          elements = {
            'repl',
            'console',
          },
          size = 10,
          position = 'bottom', -- Can be "bottom" or "top"
        },
      },
      floating = {
        max_height = nil,
        max_width = nil,
        border = 'single',
        mappings = {
          ['close'] = { 'q', '<Esc>' },
        },
      },
      controls = {
        enabled = vim.fn.exists '+winbar' == 1,
        element = 'repl',
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
        indent = 1,
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config']     = dapui.close
    -- Adapter executable (from Mason)
    local js                                              = vim.fn.stdpath('data') ..
        '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'

    -- Use absolute node path to avoid nvm/PATH issues
    local node                                            = vim.fn.exepath('node')
    -- Register adapters (both point to the same js-debug server)
    dap.adapters['pwa-node']                              = {
      type = 'server',
      host = '127.0.0.1',
      port = '8123',
      executable = { 
        command = "js-debug-adapter" },
    }

    -- dap.adapters['pwa-chrome']                            = dap.adapters['pwa-node']
    --
    local js_based_languages                              = { 'javascript', 'typescript', 'javascriptreact',
      'typescriptreact' }

    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
          runtimeExecutable = "Node"
        },
        -- {
        --   type = 'pwa-node',
        --   request = 'attach',
        --   name = 'Attach',
        --   processId = require('dap.utils').pick_process,
        --   cwd = '${workspaceFolder}',
        -- },
        -- {
        --   type = 'pwa-chrome',
        --   request = 'launch',
        --   name = 'Start Chrome on localhost',
        --   url = 'http://localhost:3000',
        --   webRoot = '${workspaceFolder}',
        --   -- userDataDir = '${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir', -- optional
        -- },
      }
    end
  end,
}
