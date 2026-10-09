---@type vim.lsp.Config
-- nixd. Buffer-local indent options live in ftplugin/nix.lua.
return {
  cmd = { 'nixd' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', 'default.nix', 'shell.nix', '.git' },
  -- Show inlay hints by default; <leader>lh still toggles them per buffer.
  on_attach = function(_, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end,
}
