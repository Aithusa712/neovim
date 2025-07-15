-- format.lua
-- Autoformat setup using Mason, Conform, and Mason-Conform
return {
  -- 1) Mason package manager
  {
    'williamboman/mason.nvim',
    config = true,
  },

  -- 2) Conform: fast async formatter plugin
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format {
            async = true,
            lsp_fallback = true }
        end,
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      -- Specify filetype-specific formatters; Mason-Conform will auto-discover others
      -- formatters_by_ft = {
      --   python = { 'black' },
      --
      -- },
    },
  },

  -- 3) Mason-Conform bridge: auto-register Mason-installed formatters
  {
    'LittleEndianRoot/mason-conform',
    dependencies = {
      'williamboman/mason.nvim',
      'stevearc/conform.nvim',
    },
    after = 'conform.nvim',
    config = function()
      require('mason-conform').setup()
    end,
  },
}
