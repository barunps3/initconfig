-- Neovim does not have built-in support for the bicep filetype which is required for lspconfig to automatically launch the language server.
vim.cmd [[ autocmd BufNewFile,BufRead *.bicep set filetype=bicep ]]

local root_dirname = vim.fs.dirname(vim.fs.find({'main.bicep', '.git', '.github'}, { upward = true })[1])
vim.lsp.start({
    name = "bicepls",
    cmd = { "dotnet", "/Users/fixcgi6/.config/nvim/langserver/bicep-langserver/Bicep.LangServer.dll" },
    root_dir = root_dirname,
})
