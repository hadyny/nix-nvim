if vim.g.did_load_scrollbar_plugin then
  return
end
vim.g.did_load_scrollbar_plugin = true

require('hlslens').setup()

require('scrollbar').setup {
  handle = {
    blend = 30,
  },
}

require('scrollbar.handlers.search').setup()
