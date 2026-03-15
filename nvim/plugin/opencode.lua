if vim.g.did_load_ai_plugin then
  return
end
vim.g.did_load_ai_plugin = true

vim.o.autoread = true

local map = vim.keymap.set

map({ 'n', 'x' }, '<C-a>', function()
  require('opencode').ask('@this: ', { submit = true })
end, { desc = 'Ask opencode' })

map({ 'n', 't' }, '<C-.>', function()
  require('opencode').toggle()
end, { desc = 'Toggle opencode' })

map({ 'n', 'x' }, '<C-x>', function()
  require('opencode').select()
end, { desc = 'Opencode action' })

map({ 'n', 'x' }, 'go', function()
  return require('opencode').operator('@this ')
end, { desc = 'Add range to opencode', expr = true })

map('n', 'goo', function()
  return require('opencode').operator('@this ') .. '_'
end, { desc = 'Add line to opencode', expr = true })

map('n', '<S-C-d>', function()
  require('opencode').command('session.half.page.down')
end, { desc = 'Scroll opencode down' })

map('n', '<S-C-u>', function()
  require('opencode').command('session.half.page.up')
end, { desc = 'Scroll opencode up' })
