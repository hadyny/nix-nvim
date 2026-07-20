if vim.g.did_load_yazi_plugin then
  return
end
vim.g.did_load_yazi_plugin = true

require('yazi').setup {
  -- Let yazi manage directory buffers instead of netrw.
  open_for_directories = false,
}

vim.keymap.set('n', '<leader>e', '<cmd>Yazi<CR>', { desc = 'Explorer (yazi)' })
