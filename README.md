
# My Neovim Config (Lazy.nvim-based)

This is Neovim configuration built on top of [Lazy.nvim](https://github.com/folke/lazy.nvim). It's modular, clean, and includes support for modern development with LSP, DAP, formatting, Git, AI coding tools, markdown, and more.

---

## Directory Structure

```
├── lua
│   ├── plugins                 # Plugin specs (loaded via Lazy)
│   ├── custom/plugins          # Personal plugin extensions/overrides
│   ├── settings                # Global keymaps and options
│   ├── custom/themes          # Custom themes
│   └── notUsedPlugins         # Optional/disabled plugins
```

---

## Plugins

* **LSP**: `nvim-lspconfig`, `mason`, `fidget.nvim`, `nvim-cmp`
* **DAP**: `nvim-dap`, `nvim-dap-go`, `nvim-dap-ui`
* **Completion**: `blink.cmp`, `friendly-snippets`
* **Formatting**: `conform.nvim`, `mason-conform`, `mason-tool-installer`, `nvim-lint`
* **Git**: `gitsigns.nvim`, `vim-fugitive`
* **UI**: `dashboard-nvim`, `noice.nvim`, `which-key.nvim`, `lualine.nvim`, `indent-blankline.nvim`
* **Telescope**: `telescope.nvim`, `telescope-ui-select`, `fzf-native`
* **Markdown**: `render-markdown.nvim`
* **Terminal**: `toggleterm.nvim`
* **Copilot**: `copilot.vim`, `codecompanion.nvim`
* **Utility**: `nvim-autopairs`, `iron.nvim`

---

## Keybindings
 

### General

* `<Esc>` — Clear search highlights
* `<CR>` — Execute dashboard item
* `<leader><space>` — Open buffer list
* `<leader>f` — Format buffer

### Window Navigation
* `<Left>` — Move to window left
* `<Right>` — Move to window right
* `<Up>` — Move to window up
* `<Down>` — Move to window down
* `<S-Up>` — Resize window up
* `<S-Down>` — Resize window down
* `<S-Left>` — Resize window left
* `<S-Right>` — Resize window right

### Window Management 
* `<C-w>h` — Go to the left window
* `<C-w>j` — Go to the down window
* `<C-w>k` — Go to the up window
* `<C-w>l` — Go to the right window

* `<C-w>H` — Move window to far left
* `<C-w>J` — Move window to far bottom
* `<C-w>K` — Move window to far top
* `<C-w>L` — Move window to far right

* `<C-w>o` — Close all other windows
* `<C-w>q` — Quit a window

* `<C-w>s` — Split window horizontally
* `<C-w>v` — Split window vertically

* `<C-w>T` — Break out into a new tab
* `<C-w>w` — Switch to the next window
* `<C-w>x` — Swap current with next

* `<C-w>+` — Increase height
* `<C-w>-` — Decrease height

* `<C-w><` — Decrease width
* `<C-w>>` — Increase width

* `<C-w>_` — Max out the height
* `<C-w>|` — Max out the width

* `<C-w>=` — Equalize window dimensions

* `<C-w>d` — Show diagnostics under the cursor
* `<C-w>^D` — Show diagnostics under the cursor
### Telescope

* `<leader>sf` — Search files
* `<leader>ss` — Select Telescope
* `<leader>sw` — Search current word
* `<leader>sg` — Live grep
* `<leader>cd` — Diagnostics
* `<leader>sr` — Resume last search
* `<leader>s.` — Recent files
* `<leader>s/` — Live grep in open files
* `<leader>sn` — Search Neovim config files
* `<leader>sk` — Search keymaps
* `<leader>sh` — Search help

### Debugging (DAP)

* `<leader>d1` — Start/Continue
* `<leader>d2` — Step Into
* `<leader>d3` — Step Over
* `<leader>d4` — Step Out
* `<leader>db` — Toggle Breakpoint
* `<leader>dB` — Set conditional breakpoint
* `<leader>dt` — Toggle DAP UI

### Git

* `<leader>gs` — Git status
* `<leader>gd` — Git diff
* `<leader>gp` — Git push
* `<leader>gl` — Git pull

### Copilot & CodeCompanion

* `<leader>co` — Copilot enable
* `<leader>cn` — Copilot disable
* `<leader>cp` — CodeCompanion action palette
* `<leader>cc` — Toggle CodeCompanion chat
* `v <leader>cp` — CodeCompanion visual mode

### UI & Tools

* `<leader>ne` — Show Noice messages
* `<leader>tn` — Open Telescope colorschemes
* `<leader>nl` — Toggle line numbers
* `<leader>nr` — Toggle relative line numbers
* `<leader>tm` — Toggle between markdown and python filetypes

### Linting
* `<leader>ll` — Run linting

### Hover
* `K` — Show hover information
* `gK` — Select hover source
* `<C-p>` — Previous hover source
* `<C-n>` — Next hover source
* `<MouseMove>` — Trigger hover

### Iron
* `<space>rf` — Run file in REPL
* `<space>rh` — Restart REPL

### Telescope
* `<leader>sh` — Search help
* `<leader>sk` — Search keymaps
* `<leader>sf` — Search files
* `<leader>ss` — Select Telescope
* `<leader>sw` — Search current word
* `<leader>sg` — Live grep
* `<leader>cd` — Show diagnostics
* `<leader>sr` — Resume search
* `<leader>s.` — Recent files
* `<leader><leader>` — Open buffer list
* `<leader>/` — Fuzzy search in current buffer
* `<leader>s/` — Live grep open files
* `<leader>sn` — Search Neovim config files



