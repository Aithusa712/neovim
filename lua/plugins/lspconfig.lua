return {
  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',

    dependencies = {
      -- Mason for managing LSP servers and external tools
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- LSP progress UI
      { 'j-hui/fidget.nvim', opts = {} },

      -- Lua-specific enhancements
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },

      'Bilal2453/luvit-meta',

      -- Completion
      'saghen/blink.cmp',
    },

    config = function()
      --------------------------------------------------------------------------
      -- Diagnostics Toggle
      --------------------------------------------------------------------------

      local function toggle_inline_diagnostics()
        local cfg = vim.diagnostic.config()

        local use_lines = not cfg.virtual_lines
        local use_text = not cfg.virtual_text

        vim.diagnostic.config({
          virtual_lines = use_lines,
          virtual_text = use_text,
        })

        print(
          ('Diagnostics toggled: virtual_lines=%s, virtual_text=%s'):format(
            tostring(use_lines),
            tostring(use_text)
          )
        )
      end

      --------------------------------------------------------------------------
      -- LSP Attach Autocommands
      --------------------------------------------------------------------------

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),

        callback = function(ev)
          local buf = ev.buf

          local function map(keys, fn, desc)
            vim.keymap.set('n', keys, fn, {
              buffer = buf,
              desc = 'LSP: ' .. desc,
            })
          end

          ----------------------------------------------------------------------
          -- Telescope Integrations
          ----------------------------------------------------------------------

          map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')

          map(
            'gI',
            require('telescope.builtin').lsp_implementations,
            'Goto Implementation'
          )

          map('gr', require('telescope.builtin').lsp_references, 'List References')

          map(
            '<leader>ds',
            require('telescope.builtin').lsp_document_symbols,
            'Document Symbols'
          )

          map(
            '<leader>ws',
            require('telescope.builtin').lsp_dynamic_workspace_symbols,
            'Workspace Symbols'
          )

          map(
            '<leader>D',
            require('telescope.builtin').lsp_type_definitions,
            'Type Definition'
          )

          map(
            '<leader>q',
            require('telescope.builtin').diagnostics,
            'Show Diagnostics'
          )

          ----------------------------------------------------------------------
          -- LSP Actions
          ----------------------------------------------------------------------

          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
          map('<leader>rn', vim.lsp.buf.rename, 'Rename')
          map('<leader>Q', vim.lsp.buf.code_action, '[Q]uickFix')
          map('<leader>td', toggle_inline_diagnostics, 'Toggle Diagnostics')

          ----------------------------------------------------------------------
          -- Document Highlight
          ----------------------------------------------------------------------

          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          if client and client.server_capabilities.documentHighlightProvider then
            local hl_grp =
              vim.api.nvim_create_augroup('LspDocumentHighlight', {
                clear = false,
              })

            vim.opt.updatetime = 1000

            vim.api.nvim_create_autocmd(
              { 'CursorHold', 'CursorHoldI' },
              {
                group = hl_grp,
                buffer = buf,
                callback = vim.lsp.buf.document_highlight,
              }
            )

            vim.api.nvim_create_autocmd('CursorMoved', {
              group = hl_grp,
              buffer = buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      --------------------------------------------------------------------------
      -- Capabilities
      --------------------------------------------------------------------------

      local capabilities =
        require('blink.cmp').get_lsp_capabilities()

      --------------------------------------------------------------------------
      -- Servers
      --------------------------------------------------------------------------

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },

              diagnostics = {
                globals = { 'vim' },
              },
            },
          },
        },
      }

      --------------------------------------------------------------------------
      -- Mason
      --------------------------------------------------------------------------

      require('mason').setup()

      require('mason-tool-installer').setup({
        ensure_installed = {
          'stylua',
        },
      })

      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
      })

      --------------------------------------------------------------------------
      -- Neovim 0.11+ LSP Setup
      --------------------------------------------------------------------------

      for name, opts in pairs(servers) do
        vim.lsp.config(
          name,
          vim.tbl_deep_extend('force', {}, opts, {
            capabilities = capabilities,
          })
        )

        vim.lsp.enable(name)
      end
    end,
  },
}
