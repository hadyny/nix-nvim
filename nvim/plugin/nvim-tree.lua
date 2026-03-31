if vim.g.did_load_nvim_tree_plugin then
  return
end
vim.g.did_load_nvim_tree_plugin = true

require('nvim-tree').setup {
  view = {
    side = 'right',
  },
}

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Explorer' })
