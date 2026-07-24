---@type vim.lsp.Config
-- marksman. Buffer-local comment options live in ftplugin/markdown.lua.
return {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_markers = { '.marksman.toml', '.git' },
}
