if vim.g.did_load_lsp_progress_plugin then
  return
end
vim.g.did_load_lsp_progress_plugin = true

-- Simple LSP progress notification using vim.notify
vim.api.nvim_create_autocmd('LspProgress', {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local message = ev.data.params.value.message or ''
    local percentage = ev.data.params.value.percentage or 0
    local title = ev.data.params.value.title or 'LSP'
    
    if client then
      local icon = ev.data.params.value.kind == 'end' and ' '
        or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      
      local msg = string.format('%s %s %s%%', icon, message, percentage)
      vim.notify(msg, vim.log.levels.INFO, {
        title = string.format('%s: %s', client.name, title),
      })
    end
  end,
})
