if vim.g.did_load_plugins_plugin then
  return
end
vim.g.did_load_plugins_plugin = true

-- conform
local conform = require('conform')

conform.setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    csharp = { 'csharpier' },
    javascript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    typescript = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    css = { 'prettierd' },
    html = { 'prettierd' },
    json = { 'prettierd' },
    yaml = { 'prettierd' },
    markdown = { 'prettierd' },
    graphql = { 'prettierd' },
    nix = { 'nixfmt' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
}

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- yazi

vim.g.loaded_netrwPlugin = 1
require('yazi').setup {
  open_for_directories = true,
}
vim.keymap.set({ 'n', 'v' }, '<leader>e', function()
  require('yazi').yazi()
end, { desc = 'Yazi' })

-- treesitter
require('nvim-treesitter').setup {}
