---@type vim.lsp.Config
-- gopls. Buffer-local indent options live in ftplugin/go.lua.
return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', 'go.sum', '.git' },
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
