if vim.g.did_load_plugins_plugin then
  return
end
vim.g.did_load_plugins_plugin = true

-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default config

-- gitsigns
require('gitsigns').setup {
  on_attach = function(_)
    local gs = package.loaded.gitsigns
    -- Navigation
    vim.keymap.set({ 'n', 'v' }, ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'Jump to next hunk' })

    vim.keymap.set({ 'n', 'v' }, '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'Jump to previous hunk' })
  end,
}

-- conform
local conform = require('conform')

conform.setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    csharp = { 'csharpier' },
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
