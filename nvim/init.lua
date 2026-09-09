-- Set Options
vim.opt.clipboard = "unnamedplus"
vim.opt.nu = true
vim.opt.history = 50
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 8
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.list = true --display listchars
vim.opt.listchars = {
  tab = "| ",
  trail = "-",
  nbsp = "+"
}

-- Load leader keys before lazy
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Plugins
require("config.lazy")

-- Keybindings
-- special keymaps
vim.keymap.set('n', '<Leader>w', ':w<CR>')
vim.keymap.set('n', '<Leader>z', '<C-w>v:Explore<CR>')
vim.keymap.set('n', '<Leader><Backspace>', ':Rexplore<CR>')
vim.keymap.set('i', '"', '""<left>', { noremap = true })
vim.keymap.set('i', "'", "''<left>", { noremap = true })
vim.keymap.set('i', '(', '()<left>', { noremap = true })
vim.keymap.set('i', '[', '[]<left>', { noremap = true })
vim.keymap.set('i', '{', '{}<left>', { noremap = true })
vim.keymap.set('i', '{<CR>', '{}<left><CR><Esc>O', { noremap = true })

-- change setting keymaps
vim.keymap.set('n', 'noh', ':nohls<CR>')
vim.keymap.set('n', 'rnu', ':set rnu!<CR>')

-- motion keymaps
vim.keymap.set({'n', 'v'}, 'S', '5j')
vim.keymap.set({'n', 'v'}, 'W', '5k')

-- Control Buffers
vim.keymap.set({'n'}, 'cql', ':cclose<CR>')
vim.keymap.set({'n'}, 'cll', ':lclose<CR>')

-- Autocommands
-- Before writing the file
-- Trailing whitespaces are removed before writing the file
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd("%s/\\s\\+$//e")
  end
})

-- Diagnostic
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist)
vim.diagnostic.config({
  virtual_text = false,
})

-- Language Servers are configured in ftplugin/ folder
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    -- Enable completion triggered by <c-x><c-o>
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      --print("in if function")
      --print(tostring(vim.bo[bufnr].omnifunc))
    end
    --print("out of if function")
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

-- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

  -- Show diagnostic logs in hover window
  -- note: this setting is global and should be set only once
  vim.o.updatetime = 250
  --vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  --  group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
  --  callback = function ()
  --    vim.diagnostic.open_float(nil, {focus=false})
  --  end
  --})

  --vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  --group = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true }),
  --  callback = function ()
  --    vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
  --  end
  --})

  end,
})

-- install treesitter-cli - https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md#installation
require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}

require("nvim-treesitter").install({
  "go",
  "gomod",
  "query",
  "bicep",
  "python",
  "javascript",
  "lua",
  "markdown",
  "markdown_inline",
  "vimdoc"
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'go', 'python', 'bicep', 'lua', 'markdown', 'javascript'
  },
  callback = function()
    -- start highlighting
    vim.treesitter.start()
  end,
})

-- Colorscheme
vim.cmd.colorscheme("moonfly")
