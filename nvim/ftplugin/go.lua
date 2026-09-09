vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.shiftwidth = 4

local root_dirname = vim.fs.dirname(vim.fs.find({
    'go.work',
    'go.mod',
    '.git'}, { upward = true })[1])


vim.lsp.start({
    name = "gopls",
    cmd = { "gopls" },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_dir = root_dirname,
    single_file_support = true,
    print(string.format("Go Project Dir:%s", root_dirname))
})


vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})
