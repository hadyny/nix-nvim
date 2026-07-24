---@type vim.lsp.Config
-- nixd. Buffer-local indent options live in ftplugin/nix.lua.
return {
  cmd = { 'nixd' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', 'default.nix', 'shell.nix', '.git' },
}
