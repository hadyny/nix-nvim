if vim.g.did_load_lazydev_plugin then
  return
end
vim.g.did_load_lazydev_plugin = true

require('lazydev').setup()
