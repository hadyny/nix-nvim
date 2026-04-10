if vim.g.did_load_which_key_plugin then
  return
end
vim.g.did_load_which_key_plugin = true

require('which-key').setup {
  spec = {
    { '<leader>c', group = 'Claude' },
    { '<leader>cs', group = 'C#' },
    { '<leader>d', group = 'Diagnostics' },
    { '<leader>f', group = 'Find' },
    { '<leader>g', group = 'Git' },
    { '<leader>h', group = 'Hunks' },
    { '<leader>ht', group = 'Toggle' },
    { '<leader>l', group = 'LSP' },
    { '<leader>lp', group = 'Peek' },
    { '<leader>lw', group = 'Workspace' },
    { '<leader>q', group = 'Quickfix' },
    { '<leader>t', group = 'Toggle' },
  },
}
