if vim.g.did_load_diffview_plugin then
  return
end
vim.g.did_load_diffview_plugin = true

require('diffview').setup {}

vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = 'Diffview open' })
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', { desc = 'Diffview file history' })
vim.keymap.set('n', '<leader>gH', '<cmd>DiffviewFileHistory<cr>', { desc = 'Diffview branch history' })
