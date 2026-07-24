vim.bo.comments = ':---,:--'

-- LSP servers for web filetypes (vtsls, eslint, tailwindcss, graphql) are
-- configured in nvim/lsp/ and enabled in nvim/plugin/lsp.lua.

-- Filter out vtsls' "Convert named/default export" refactor: TypeScript 5.8 reports
-- it as applicable but throws during codeAction/resolve (Expected applicable refactor info).
vim.keymap.set({ 'n', 'x' }, 'gra', function()
  vim.lsp.buf.code_action {
    filter = function(action)
      return not (action.title or ''):match('^Convert .* export to .* export$')
    end,
  }
end, { buffer = 0, desc = 'Code action' })
