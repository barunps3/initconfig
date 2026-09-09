vim.opt.shiftwidth = 4
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.keymap.set('n', '<C-c>', '_i//<Esc>', { noremap = true })
vim.keymap.set('n', '<C-u>', '_xx', { noremap = true })

local root_dirname = vim.fs.dirname(vim.fs.find({
    'compile_commands.json',
    '.ccls',
    '.git',
    }, { upward = true })[1])


vim.lsp.start({
    name = "ccls",
    cmd = { "ccls" },
    root_dir = root_dirname,
    print(string.format("C Project Dir:%s", root_dirname))
})
