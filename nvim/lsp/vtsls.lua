---@type vim.lsp.Config
-- vtsls (TypeScript/JavaScript). The `gra` code-action filter is buffer-local
-- and lives in ftplugin/typescript.lua.
return {
  cmd = { 'vtsls', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' },
  init_options = {
    hostInfo = 'neovim',
  },
}
