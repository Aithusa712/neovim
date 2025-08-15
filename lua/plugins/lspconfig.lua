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
      { 'j-hui/fidget.nvim',       opts = {} },

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
      'saghen/blink.cmp',
    },
    config = function()
      -- Toggle between inline diagnostics and virtual text
      local function toggle_inline_diagnostics()
        local cfg = vim.diagnostic.config()
        local use_lines = not cfg.virtual_lines
        local use_text = not cfg.virtual_text
        vim.diagnostic.config {
          virtual_lines = use_lines,
          virtual_text  = use_text,
        }
        print(('Diagnostics toggled: virtual_lines=%s, virtual_text=%s'):format(
          tostring(use_lines), tostring(use_text)
        ))
      end

      -- Map LSP-related keybindings on attach
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
        callback = function(ev)
          local buf = ev.buf
          local function map(keys, fn, desc)
            vim.keymap.set('n', keys, fn, { buffer = buf, desc = 'LSP: ' .. desc })
          end

          -- Telescope integrations
          map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
          map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
          map('gr', require('telescope.builtin').lsp_references, 'List References')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
          map('<leader>q', require('telescope.builtin').diagnostics, 'Show Diagnostics')

          -- LSP actions
          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
          map('<leader>rn', vim.lsp.buf.rename, 'Rename')
          map('<leader>Q', vim.lsp.buf.code_action, '[Q]uickFix')
          map('<leader>td', toggle_inline_diagnostics, 'Toggle Diagnostics Display')

          -- Highlight symbol under cursor
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client.server_capabilities.documentHighlightProvider then
            local hl_grp = vim.api.nvim_create_augroup('LspDocumentHighlight', { clear = false })
            vim.opt.updatetime = 1000
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              group = hl_grp,
              buffer = buf,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
              group = hl_grp,
              buffer = buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })
      -- nvim CMP, Alternative formatter.
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities(
      --   vim.lsp.protocol.make_client_capabilities()
      -- )
      -- Enhance LSP capabilities for completion
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Define servers and settings
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
        },
      }

      -- Initialize Mason and ensure tools are installed
      require('mason').setup()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'stylua',
        },
      }
      require('mason-lspconfig').setup {
        ensure_installed       = vim.tbl_keys(servers),
        automatic_installation = true,
        automatic_enable       = true,
      }

      -- Setup each LSP server
      for name, opts in pairs(servers) do
        require('lspconfig')[name].setup(vim.tbl_deep_extend('force', {}, opts, {
          capabilities = capabilities,
        }))
      end
    end,
  },
}
