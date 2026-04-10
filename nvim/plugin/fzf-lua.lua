if vim.g.did_load_fzf_lua_plugin then
  return
end
vim.g.did_load_fzf_lua_plugin = true

local fzf = require('fzf-lua')

fzf.setup {
  {
    'fzf-native',
    'borderless-full',
  },
  winopts = {
    height = 0.85,
    width = 0.80,
    preview = {
      default = 'bat',
      horizontal = 'right:60%',
    },
  },
}

fzf.register_ui_select()

local map = vim.keymap.set

map('n', '<leader>fr', fzf.oldfiles, { desc = 'Recent files' })
map('n', '<leader>ff', fzf.files, { desc = 'Find files' })
map({ 'n', 'v', 'x' }, '<leader>fb', fzf.buffers, { desc = 'Find buffers' })
map({ 'n', 'v', 'x' }, '<leader>/', fzf.live_grep, { desc = 'Grep' })
map({ 'n', 'v', 'x' }, '<leader><leader>', fzf.commands, { desc = 'Commands' })
