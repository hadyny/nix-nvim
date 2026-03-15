if vim.g.did_load_highlight_colors_plugin then
  return
end
vim.g.did_load_highlight_colors_plugin = true

require('nvim-highlight-colors').setup {
  render = 'virtual',
  enable_named_colors = true,
  enable_tailwind = true,
}
