if vim.g.did_load_which_key_plugin then
  return
end
vim.g.did_load_which_key_plugin = true

require('which-key').setup {
  spec = {
    { '<leader>1', hidden = true },
    { '<leader>2', hidden = true },
    { '<leader>3', hidden = true },
    { '<leader>4', hidden = true },
    { '<leader>5', hidden = true },
    { '<leader>6', hidden = true },
    { '<leader>7', hidden = true },
    { '<leader>8', hidden = true },
    { '<leader>9', group = '99' },
  },
}
