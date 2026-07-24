if vim.g.did_load_zk_plugin then
  return
end
vim.g.did_load_zk_plugin = true

require('zk').setup {
  -- Reuse telescope (this config's fuzzy finder) for zk pickers.
  picker = 'telescope',
  lsp = {
    config = {
      name = 'zk',
      cmd = { 'zk', 'lsp' },
      filetypes = { 'markdown' },
    },
    -- Attach `zk lsp` to markdown buffers (link completion, dead-link
    -- diagnostics). marksman also attaches to markdown; the two coexist.
    auto_attach = {
      enabled = true,
    },
  },
  tags = {
    multi_select_strategy = 'AND',
  },
}

local map = vim.keymap.set
local commands = require('zk.commands')

-- <leader>z: zk / notes
map('n', '<leader>zn', function()
  commands.get('ZkNew') { title = vim.fn.input('Title: ') }
end, { desc = 'New note' })
map('n', '<leader>zo', '<Cmd>ZkNotes { sort = { "modified" } }<CR>', { desc = 'Open notes' })
map('n', '<leader>zt', '<Cmd>ZkTags<CR>', { desc = 'Tags' })
map('n', '<leader>zf', function()
  commands.get('ZkNotes') { match = { vim.fn.input('Search: ') } }
end, { desc = 'Find notes (content)' })
map('n', '<leader>zb', '<Cmd>ZkBacklinks<CR>', { desc = 'Backlinks' })
map('n', '<leader>zl', '<Cmd>ZkLinks<CR>', { desc = 'Outgoing links' })
map('n', '<leader>zi', '<Cmd>ZkInsertLink<CR>', { desc = 'Insert link' })

-- Visual mode: act on the selection.
map('x', '<leader>zf', ":'<,'>ZkMatch<CR>", { desc = 'Match selection' })
map('x', '<leader>zi', ":'<,'>ZkInsertLinkAtSelection<CR>", { desc = 'Insert link (from selection)' })
map('x', '<leader>zn', ":'<,'>ZkNewFromTitleSelection<CR>", { desc = 'New note from selection (title)' })
