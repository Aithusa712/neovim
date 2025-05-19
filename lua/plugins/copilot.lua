return {
  -- GitHub Copilot
  {
    'github/copilot.vim',
   -- event = 'InsertEnter', -- Or "BufReadPost", "VeryLazy", etc.  See below for explanation
    config = function()
      -- Optional:  Configure Copilot (if needed).  See Copilot's documentation for available options.
      vim.g.copilot_no_maps = 1 -- Disable default mappings (optional)
      -- Example of a configuration function
      -- vim.cmd("Copilot setup") -- Might be required to initialize copilot
    end,
    dependencies = {
      'nvim-lua/plenary.nvim', -- Copilot depends on plenary
    },
  },

  -- other plugins...
}
