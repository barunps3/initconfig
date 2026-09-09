local root_dirname = vim.fs.dirname(vim.fs.find({
    'pyproject.toml',
    'setup.py',
    'requirements.txt'}, { upward = true })[1])

local python_path = vim.trim(vim.fn.system("pyenv which python 2>/dev/null"))
vim.lsp.start({
    name = "pyright",
    cmd = { "pyright-langserver", "--stdio" },
    root_dir = root_dirname,
    settings = {
      python = {
        pythonPath = python_path,
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = 'openFilesOnly',
        },
      },
    },
    print(string.format("Python Project Dir:%s", root_dirname))
})
