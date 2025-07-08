-- NOTE: [[ Basic Keymaps ]]
vim.keymap.set('v', '<leader>cp', '<cmd>CodeCompanion<CR>', { desc = 'Code [C]ompanion [V]isual' })

--  See `:help vim.keymap.set()`
vim.keymap.set('n', '<leader>tn', '<cmd>Telescope colorscheme<CR>', { desc = 'Open colorschemes' })
vim.keymap.set('n', '<leader>nr', '<cmd>setl rnu!<CR>', { desc = 'Set Relative Number Line' })
vim.keymap.set('n', '<leader>nl', '<cmd>setl nu!<CR>', { desc = 'Set Number Line' })
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Diagnostic keymaps
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }) -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier

-- NOTE: [[Buffers]]
vim.keymap.set('n', 'gj', '<cmd>bprev<CR>', { desc = 'Go to previous buffer' }) -- Go to prev buffer
vim.keymap.set('n', 'gk', '<cmd>bnext<CR>', { desc = 'Go to next buffer' }) -- Go to next buffer
vim.keymap.set('n', 'g/', '<cmd>bd<CR>', { desc = 'Close current buffer' }) -- Close Buffer
vim.keymap.set('n', '<A-t>', '<cmd>terminal<CR>') --open terminal

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<Left>', '<cmd>wincmd h<CR>')
vim.keymap.set('n', '<Right>', '<cmd>wincmd l<CR>')
vim.keymap.set('n', '<Up>', '<cmd>wincmd k<CR>')
vim.keymap.set('n', '<Down>', '<cmd>wincmd j<CR>')

vim.keymap.set('n', '<S-Up>', '<cmd>resize -2<CR>')
vim.keymap.set('n', '<S-Down>', '<cmd>resize +2<CR>')
vim.keymap.set('n', '<S-right>', '<cmd>vertical resize +2<CR>')
vim.keymap.set('n', '<S-left>', '<cmd>vertical resize -2<CR>')

vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { desc = 'LSP code action' })

vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat toggle<CR>', { desc = 'Code [C]ompanion [C]hat' })
vim.keymap.set('v', '<leader>cv', '<cmd>CodeCompanion<CR>', { desc = 'Code [C]ompanion [V]isual' })
vim.keymap.set('n', '<leader>cp', '<cmd>CodeCompanionActions<CR>', { desc = 'Code [C]ompanion Action [P]allete' })

-- NOTE:  Copilot

vim.keymap.set('n', '<leader>cn', '<cmd>Copilot disable<CR>', { desc = '[C]opilot [D]isable' })
vim.keymap.set('n', '<leader>co', '<cmd>Copilot enable<CR>', { desc = '[C]opilot [E]nable' })

-- vim.keymap.set('', 'C-Ia' )

-- Map Ctrl + t to toggle a terminal with specific options
vim.keymap.set('n', '<C-t>', '<cmd>ToggleTerm size=30 direction=float name=Terminal<CR>', { silent = true })

-- I want a keymap to toggle between markdown and py files
vim.keymap.set('n', '<leader>tm', function()
  local filetype = vim.bo.filetype
  if filetype == 'markdown' then
    vim.cmd 'set ft=python'
  elseif filetype == 'python' then
    vim.cmd 'set ft=markdown'
  end
end, { desc = 'Toggle between markdown and python filetypes' })

vim.keymap.set('n', '<leader>ne', '<cmd>Noice all<CR>', { desc = 'Noice Messages' })
