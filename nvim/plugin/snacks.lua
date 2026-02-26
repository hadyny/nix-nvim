if vim.g.did_load_snacks_plugin then
  return
end
vim.g.did_load_snacks_plugin = true

require('snacks').setup {
  picker = {
    sources = {
      explorer = {
        layout = { layout = { position = 'right' } },
      },
    },
  },
  notifier = {},
  statuscolumn = {},
  input = {},
}

vim.api.nvim_create_autocmd('LspProgress', {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    vim.notify(vim.lsp.status(), 'info', {
      id = 'lsp_progress',
      title = 'LSP Progress',
      opts = function(notif)
        notif.icon = ev.data.params.value.kind == 'end' and ' '
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

vim.keymap.set({ 'n', 'v', 'x' }, '<leader><leader>', function()
  Snacks.picker.smart()
end, { desc = 'Files' })

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>b', function()
  Snacks.picker.buffers()
end, { desc = 'Buffers' })

vim.keymap.set({ 'n', 'v', 'x' }, '<leader>/', function()
  Snacks.picker.grep()
end, { desc = 'Search' })
