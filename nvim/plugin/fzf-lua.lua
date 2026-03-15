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
