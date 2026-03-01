if vim.g.did_load_fzf_lua_plugin then
  return
end
vim.g.did_load_fzf_lua_plugin = true

require('fzf-lua').setup {
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

-- Register fzf-lua as the handler for vim.ui.select
require('fzf-lua').register_ui_select()

-- Smart file picker (files or git files if in a git repo)
vim.keymap.set({ 'n', 'v', 'x' }, '<leader><leader>', function()
  require('fzf-lua').files()
end, { desc = 'Files' })

-- Buffer picker
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>b', function()
  require('fzf-lua').buffers()
end, { desc = 'Buffers' })

-- Live grep/search
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>/', function()
  require('fzf-lua').live_grep()
end, { desc = 'Search' })
