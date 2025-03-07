-- NOTE: [[ Basic Keymaps ]]

--  See `:help vim.keymap.set()`
vim.keymap.set('n', '<leader>tn', '<cmd>Telescope colorscheme<CR>', { desc = 'Open colorschemes' })
vim.keymap.set('n', '<leader>nr', '<cmd>setl rnu!<CR>', { desc = 'Set Relative Number Line' })
vim.keymap.set('n', '<leader>nl', '<cmd>setl nu!<CR>', { desc = 'Set Number Line' })
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }) -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier

-- NOTE: [[Buffers]]
vim.keymap.set('n', 'gh', '<cmd>bprev<CR>', { desc = 'Go to previous buffer' }) -- Go to prev buffer
vim.keymap.set('n', 'gg', '<cmd>bnext<CR>', { desc = 'Go to next buffer' }) -- Go to next buffer
vim.keymap.set('n', 'g/', '<cmd>bd<CR>', { desc = 'Close current buffer' }) -- Close Buffer
vim.keymap.set('n', '<A-t>', '<cmd>terminal<CR>') --open terminal

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
