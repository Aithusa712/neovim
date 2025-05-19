return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Lua LSP configuration
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true },
    },
    config = function()
      local function toggle_inline_diagnostics()
        local current_config = vim.diagnostic.config()
        local new_virtual_lines = current_config.virtual_lines ~= nil and not current_config.virtual_lines or false
        local new_virtual_text = current_config.virtual_text ~= nil and not current_config.virtual_text or false

        vim.diagnostic.config {
          virtual_lines = new_virtual_lines,
          virtual_text = new_virtual_text,
        }

        print('Diagnostics toggled: virtual_lines = ' .. tostring(new_virtual_lines) .. ', virtual_text = ' .. tostring(new_virtual_text))
      end
      -- Set up LSP auto commands and key mappings when LSP attaches
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Telescope keymaps for LSP functions
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('<leader>q', require('telescope.builtin').diagnostics, 'Open diagnostics [Q]uickfix list')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('<leader>td', toggle_inline_diagnostics, '[T]oggle inline [D]iagnostics')

          -- Handle LSP highlights on CursorHold
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client.server_capabilities.documentHighlightProvider then
            local group = vim.api.nvim_create_augroup('LSPDocumentHighlight', { clear = false })

            vim.opt.updatetime = 1000

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              group = group,
              buffer = event.buf,
              callback = function()
                vim.lsp.buf.document_highlight()
              end,
            })

            vim.api.nvim_create_autocmd('CursorMoved', {
              group = group,
              buffer = event.buf,
              callback = function()
                vim.lsp.buf.clear_references()
              end,
            })
          end
        end,
      })

      -- Capabilities setup for LSP client
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- LSP server configurations
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      -- Ensure LSP servers are installed and configured
      require('mason').setup()
      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, { 'stylua' })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- Configure Mason LSP config setup
      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
        automatic_enable = true,
      }

      -- Optional: You can add specific handlers for individual LSP servers
      -- e.g., Custom handler for rust-analyzer
      -- require('lspconfig')['rust_analyzer'].setup {}

      -- Default setup for other servers
      for server_name, config in pairs(servers) do
        require('lspconfig')[server_name].setup(vim.tbl_deep_extend('force', {}, config, {
          capabilities = capabilities,
        }))
      end
    end,
  },
}
