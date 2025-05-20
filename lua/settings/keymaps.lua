-- NOTE: [[ Basic Keymaps ]]

--  See `:help vim.keymap.set()`
vim.keymap.set('n', '<leader>tn', '<cmd>Telescope colorscheme<CR>', { desc = 'Open colorschemes' })
vim.keymap.set('n', '<leader>nr', '<cmd>setl rnu!<CR>', { desc = 'Set Relative Number Line' })
vim.keymap.set('n', '<leader>nl', '<cmd>setl nu!<CR>', { desc = 'Set Number Line' })
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Diagnostic keymaps
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' }) -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier

-- NOTE: [[Buffers]]
vim.keymap.set('n', 'gh', '<cmd>bprev<CR>', { desc = 'Go to previous buffer' }) -- Go to prev buffer
vim.keymap.set('n', 'gg', '<cmd>bnext<CR>', { desc = 'Go to next buffer' }) -- Go to next buffer
vim.keymap.set('n', 'g/', '<cmd>bd<CR>', { desc = 'Close current buffer' }) -- Close Buffer
vim.keymap.set('n', '<A-t>', '<cmd>terminal<CR>') --open terminal

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<Left>', '<cmd>wincmd h<CR>')
vim.keymap.set('n', '<Right>', '<cmd>wincmd l<CR>')
vim.keymap.set('n', '<Up>', '<cmd>wincmd k<CR>')
vim.keymap.set('n', '<Down>', '<cmd>wincmd j<CR>')

vim.keymap.set('n', '<S-Up>', '<cmd>resize -2<CR>')
vim.keymap.set('n', '<S-Down>', '<cmd>resize +2<CR>')
vim.keymap.set('n', '<S-Left>', '<cmd>vertical resize +2<CR>')
vim.keymap.set('n', '<S-Right>', '<cmd>vertical resize -2<CR>')

-- NOTE: 

-- vim.keymap.set('', 'C-Ia' )

-- Map Ctrl + t to toggle a terminal with specific options
vim.keymap.set('n', '<C-/>', '<cmd>ToggleTerm size=30 direction=float name=Terminal<CR>', { silent = true })

-- I want a keymap to toggle between markdown and py files
vim.keymap.set('n', '<leader>tm', function()
  local filetype = vim.bo.filetype
  if filetype == 'markdown' then
    vim.cmd('set ft=python')
  elseif filetype == 'python' then
    vim.cmd('set ft=markdown')
  end
end, { desc = 'Toggle between markdown and python filetypes' })


vim.api.nvim_create_user_command('NbConvertToPy', function()
  local current_file = vim.fn.expand('%:p')
  if current_file:match('%.ipynb$') then
    local cmd = 'jupyter nbconvert --to script ' .. vim.fn.shellescape(current_file)
    local result = vim.fn.system(cmd)
    if vim.v.shell_error == 0 then
      print("Notebook converted to Python script successfully!")
      local py_file = current_file:gsub('%.ipynb$', '.py')
      vim.cmd('edit ' .. vim.fn.fnameescape(py_file)) -- Open the converted Python file
    else
      print("Error during conversion: " .. result)
    end
  else
    print("Current file is not a Jupyter Notebook (.ipynb).")
  end
end, {})

-- Command to convert Python script to Jupyter Notebook
vim.api.nvim_create_user_command('PyConvertToNb', function()
  local current_file = vim.fn.expand('%:p')
  if current_file:match('%.py$') then
    local cmd = 'jupytext --to notebook ' .. vim.fn.shellescape(current_file)
    local result = vim.fn.system(cmd)
    if vim.v.shell_error == 0 then
      print("Python script converted to Jupyter Notebook successfully!")
      local nb_file = current_file:gsub('%.py$', '.ipynb')
      vim.cmd('edit ' .. vim.fn.fnameescape(nb_file)) -- Open the converted Notebook file
    else
      print("Error during conversion: " .. result)
    end
  else
    print("Current file is not a Python script (.py).")
  end
end, {})

-- Map <leader>tc to convert Notebook to Python script
vim.keymap.set('n', '<leader>tc', ':NbConvertToPy<CR>', { noremap = true, silent = true })

-- Map <leader>tn to convert Python script to Notebook
vim.keymap.set('n', '<leader>tn', ':PyConvertToNb<CR>', { noremap = true, silent = true })
