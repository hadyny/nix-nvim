vim.bo.comments = ':---,:--'

-- vtsls

if vim.fn.executable('vtsls') == 1 then
  local vtsls_root_files = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }

  vim.lsp.start {
    name = 'vtsls',
    cmd = { 'vtsls', '--stdio' },
    init_options = {
      hostInfo = 'neovim',
    },
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
    root_dir = vim.fs.dirname(vim.fs.find(vtsls_root_files, { upward = true })[1]),
    capabilities = require('user.lsp').make_client_capabilities(),
  }

  -- Filter out vtsls' "Convert named/default export" refactor: TypeScript 5.8 reports
  -- it as applicable but throws during codeAction/resolve (Expected applicable refactor info).
  vim.keymap.set({ 'n', 'x' }, 'gra', function()
    vim.lsp.buf.code_action {
      filter = function(action)
        return not (action.title or ''):match('^Convert .* export to .* export$')
      end,
    }
  end, { buffer = 0, desc = 'Code action' })
end

require('user.web_servers').start_eslint()
require('user.web_servers').start_tailwind()

-- graphql

local graphql_root_files = { '.graphqlrc*', '.graphql.config.*', 'graphql.config.*' }

vim.lsp.start {
  name = 'graphql',
  cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
  filetypes = { 'graphql' },
  root_dir = vim.fs.dirname(vim.fs.find(graphql_root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
}
