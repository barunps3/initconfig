-- Install the language server
-- npm install --save-dev typescript in the local project folder
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

local root_dirname = vim.fs.dirname(vim.fs.find({
    'package.json',
    'tsconfig.json',
    'jsconfig.json',
    'package-lock.json',
    'yarn.lock',
    'pnpm-lock.yaml',
    'bun.lockb',
    'bun.lock',
    '.git'
}, { upward = true })[1])

local ts_cmd = "tsc"

if root_dirname then
    local local_tsc = vim.fs.joinpath(
        root_dirname,
        "node_modules",
        ".bin",
        "tsc"
    )

    if vim.fn.executable(local_tsc) == 1 then
        ts_cmd = local_tsc
    end
end

vim.lsp.start({
    name = "tsgo",
    cmd = { ts_cmd, "--lsp", "--stdio" },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
    },
    root_dir = root_dirname,
    single_file_support = true,

    print(string.format(
        "TypeScript Project Dir: %s",
        root_dirname
    ))
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end
})
