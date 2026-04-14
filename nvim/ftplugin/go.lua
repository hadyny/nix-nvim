local gopls_cmd = 'gopls'

-- Check if gopls is available
if vim.fn.executable(gopls_cmd) ~= 1 then
  return
end

vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

local root_files = {
  'go.mod',
  'go.sum',
  '.git',
}

vim.lsp.start {
  name = 'gopls',
  cmd = { gopls_cmd },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        unusedvariable = true,
      },
      staticcheck = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
