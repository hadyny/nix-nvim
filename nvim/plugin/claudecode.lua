if vim.g.did_load_claudecode_plugin then
  return
end
vim.g.did_load_claudecode_plugin = true

require('claudecode').setup {
  auto_start = true,
  terminal = {
    split_side = 'right',
    provider = 'native',
  },
}

local map = vim.keymap.set

map('n', '<leader>cc', '<cmd>ClaudeCode<CR>', { desc = 'Claude Code toggle' })
map('n', '<leader>cf', '<cmd>ClaudeCodeFocus<CR>', { desc = 'Claude Code focus' })
map('v', '<leader>cS', '<cmd>ClaudeCodeSend<CR>', { desc = 'Claude Code send selection' })
map('n', '<leader>cm', '<cmd>ClaudeCodeSelectModel<CR>', { desc = 'Claude Code select model' })
