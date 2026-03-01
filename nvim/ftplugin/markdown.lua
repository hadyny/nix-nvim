vim.bo.comments = ':---,:--'

local markdown_ls_cmd = 'marksman'

-- Check if marksman is available
if vim.fn.executable(markdown_ls_cmd) ~= 1 then
  return
end

-- render markdown
require('render-markdown').setup {
  completions = { lsp = { enabled = true } },
  checkbox = { enabled = false },
}

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

local root_files = { '.marksman.toml', '.git' }

vim.lsp.start {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
}
