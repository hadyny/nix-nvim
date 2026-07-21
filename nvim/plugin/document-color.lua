if vim.g.did_load_document_color_plugin then
  return
end
vim.g.did_load_document_color_plugin = true

-- Neovim's built-in LSP document colour highlighting (0.12+) is enabled
-- globally by default with a 'background' style. Switch it to inline virtual
-- swatches so colours reported by LSP servers (e.g. tailwindcss) render as a
-- coloured block next to the value rather than recolouring the text background.
vim.lsp.document_color.enable(true, nil, { style = 'virtual' })
