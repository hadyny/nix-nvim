if vim.g.did_load_snacks_plugin then
  return
end
vim.g.did_load_snacks_plugin = true

require('snacks').setup {
  animate = { enabled = true },
  gitbrowse = { enabled = true },
  input = { enabled = true },
  rename = { enabled = true },
  git = { enabled = true },
  statuscolumn = { enabled = true },
  picker = { enabled = true },
  indent = {
    enabled = true,
    only_scope = true,
    animate = { enabled = true },
  },
}

-- Command history
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>:', function()
  Snacks.picker.command_history()
end, { desc = 'Commans history' })

-- Search buffer
vim.keymap.set({ 'n', 'v', 'x' }, '<C-f>', function()
  Snacks.picker.lines()
end, { desc = 'Search buffer' })

-- Git blame line
vim.keymap.set('n', '<leader>gb', function()
  Snacks.git.blame_line()
end, { desc = 'Git blame line' })

-- Browse git repository online
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>go', function()
  Snacks.gitBrowse()
end, { desc = 'View git online' })
