if vim.g.did_load_commands_plugin then
  return
end
vim.g.did_load_commands_plugin = true

local api = vim.api

-- delete current buffer
api.nvim_create_user_command('Q', 'bd % <CR>', {})

-- Custom LspInfo command
api.nvim_create_user_command('LspInfo', function()
  local buf = api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients { bufnr = buf }

  local lines = {}
  table.insert(lines, 'Language Client Info')
  table.insert(lines, '')

  if #clients == 0 then
    table.insert(lines, 'No active language servers for current buffer')
  else
    table.insert(lines, string.format('%d client(s) attached to this buffer:', #clients))
    table.insert(lines, '')

    for _, client in ipairs(clients) do
      table.insert(lines, string.format('• %s (id: %d)', client.name or 'unknown', client.id))

      -- Handle cmd which can be a table or a function
      local cmd_str = 'N/A'
      if client.config and client.config.cmd then
        if type(client.config.cmd) == 'table' then
          cmd_str = table.concat(client.config.cmd, ' ')
        elseif type(client.config.cmd) == 'function' then
          cmd_str = '<function>'
        end
      end
      table.insert(lines, string.format('  cmd: %s', cmd_str))

      table.insert(lines, string.format('  root_dir: %s', client.config and client.config.root_dir or 'N/A'))
      table.insert(
        lines,
        string.format('  filetypes: %s', table.concat(client.config and client.config.filetypes or {}, ', '))
      )
      table.insert(
        lines,
        string.format('  autostart: %s', tostring(client.config and client.config.autostart ~= false))
      )

      -- Attached buffers
      local attached_bufs = {}
      for _, bufnr in ipairs(vim.lsp.get_buffers_by_client_id(client.id)) do
        if api.nvim_buf_is_valid(bufnr) then
          local name = api.nvim_buf_get_name(bufnr)
          if name ~= '' then
            table.insert(attached_bufs, vim.fn.fnamemodify(name, ':t'))
          end
        end
      end
      if #attached_bufs > 0 then
        table.insert(lines, string.format('  attached buffers: %s', table.concat(attached_bufs, ', ')))
      end

      -- Capabilities summary
      local caps = {}
      if client.server_capabilities and client.server_capabilities.documentFormattingProvider then
        table.insert(caps, 'formatting')
      end
      if client.server_capabilities and client.server_capabilities.documentRangeFormattingProvider then
        table.insert(caps, 'range-formatting')
      end
      if client.server_capabilities and client.server_capabilities.hoverProvider then
        table.insert(caps, 'hover')
      end
      if client.server_capabilities and client.server_capabilities.completionProvider then
        table.insert(caps, 'completion')
      end
      if client.server_capabilities and client.server_capabilities.definitionProvider then
        table.insert(caps, 'definition')
      end
      if client.server_capabilities and client.server_capabilities.referencesProvider then
        table.insert(caps, 'references')
      end
      if client.server_capabilities and client.server_capabilities.renameProvider then
        table.insert(caps, 'rename')
      end
      if client.server_capabilities and client.server_capabilities.codeActionProvider then
        table.insert(caps, 'code-action')
      end
      if client.server_capabilities and client.server_capabilities.codeLensProvider then
        table.insert(caps, 'code-lens')
      end
      if client.server_capabilities and client.server_capabilities.inlayHintProvider then
        table.insert(caps, 'inlay-hints')
      end

      if #caps > 0 then
        table.insert(lines, string.format('  capabilities: %s', table.concat(caps, ', ')))
      end
      table.insert(lines, '')
    end
  end

  table.insert(lines, '')
  table.insert(lines, 'Other available language servers:')
  local all_clients = vim.lsp.get_clients()
  local other_clients = vim.tbl_filter(function(c)
    for _, client in ipairs(clients) do
      if c.id == client.id then
        return false
      end
    end
    return true
  end, all_clients)

  if #other_clients == 0 then
    table.insert(lines, '  (none)')
  else
    for _, client in ipairs(other_clients) do
      table.insert(lines, string.format('  • %s (id: %d)', client.name or 'unknown', client.id))
    end
  end

  table.insert(lines, '')
  table.insert(lines, string.format('Log file: %s', vim.lsp.get_log_path()))

  -- Create a floating window to display the info
  local width = 0
  for _, line in ipairs(lines) do
    width = math.max(width, #line)
  end
  width = math.min(width + 4, vim.o.columns - 10)

  local height = math.min(#lines + 2, vim.o.lines - 10)

  local info_buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(info_buf, 0, -1, false, lines)
  vim.bo[info_buf].bufhidden = 'wipe'
  vim.bo[info_buf].filetype = 'lspinfo'

  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = 'minimal',
    border = 'rounded',
    title = ' LSP Info ',
    title_pos = 'center',
  }

  local win = api.nvim_open_win(info_buf, true, win_opts)

  -- Close with q or ESC
  api.nvim_buf_set_keymap(info_buf, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
  api.nvim_buf_set_keymap(info_buf, 'n', '<ESC>', '<cmd>close<CR>', { noremap = true, silent = true })
end, { desc = 'Display LSP client information' })
