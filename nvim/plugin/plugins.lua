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


-- treesitter
require('nvim-treesitter').setup {}

-- render markdown
require('render-markdown').setup {
  completions = { lsp = { enabled = true } },
  checkbox = { enabled = false },
}

-- checkmate
require('checkmate').setup {
  metadata = {
    started = {
      aliases = { 'init' },
      style = { fg = '#9fd6d5' },
      get_value = function()
        return tostring(os.date('%d/%m/%y %H:%M'))
      end,
      key = '<leader>Ts',
      sort_order = 20,
    },
    done = {
      aliases = { 'completed', 'finished' },
      style = { fg = '#96de7a' },
      get_value = function()
        return tostring(os.date('%d/%m/%y %H:%M'))
      end,
      key = '<leader>Td',
      on_add = function(todo)
        require('checkmate').set_todo_state(todo, 'checked')
      end,
      on_remove = function(todo)
        require('checkmate').set_todo_state(todo, 'unchecked')
      end,
      sort_order = 30,
    },
  },
}
