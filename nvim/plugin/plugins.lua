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
    go = { 'goimports', 'gofmt' },
    nix = { 'nixfmt' },
  },
  format_on_save = {
    timeout_ms = 1500,
    lsp_format = 'fallback',
  },
}

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- render markdown
require('render-markdown').setup {
  completions = { lsp = { enabled = true } },
  checkbox = { enabled = false },
}
