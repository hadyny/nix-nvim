if vim.g.did_load_neogit_plugin then
  return
end
vim.g.did_load_neogit_plugin = true

require('neogit').setup {
  integrations = {
    diffview = false,
    fzf_lua = true,
  },
}

vim.keymap.set('n', '<leader>gc', function()
  require('neogit').open { 'commit' }
end, { desc = 'Git commit' })

vim.keymap.set('n', '<leader>gg', function()
  require('neogit').open()
end, { desc = 'Neogit' })
