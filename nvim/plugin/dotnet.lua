if vim.g.did_load_dotnet_plugins then
  return
end
vim.g.did_load_dotnet_plugins = true

vim.treesitter.language.register('c_sharp', 'csharp')

local dap = require('dap')
local dapui = require('dapui')
vim.keymap.set('n', 'q', function()
  dap.terminate()
  dap.clear_breakpoints()
end, { desc = 'Terminate and clear breakpoints' })

-- Basic debugging keymaps, feel free to change to your liking!
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>B', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })

-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

dapui.setup {
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
}
require('nvim-dap-virtual-text').setup {
  enabled = true, -- enable this plugin (the default)
  enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true, -- show stop reason when stopped for exceptions
  commented = false, -- prefix virtual text with comment string
  only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
  all_references = false, -- show virtual text on all all references of the variable (not only definitions)
  clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
  display_callback = function(variable, buf, stackframe, node, options)
    if options.virt_text_pos == 'inline' then
      return ' = ' .. variable.value
    else
      return variable.name .. ' = ' .. variable.value
    end
  end,
  -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
  virt_text_pos = vim.fn.has('nvim-0.10') == 1 and 'inline' or 'eol',

  -- experimental features:
  all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
}

require('easy-dotnet').setup {
  picker = 'fzf',
}

require('nvim-tree').setup {
  view = {
    side = 'right',
  },
}

require('csharp-explorer').setup {}

local hopcsharp = require('hopcsharp')

hopcsharp.setup {
  hop = {
    jump_on_quickfix = false,
    filter_entry_under_cursor = true,
  },
  database = {
    folder_path = vim.fn.stdpath('state'),
    buffer_size = 10000,
  },
}

-- database
vim.keymap.set('n', '<leader>hD', hopcsharp.init_database, { desc = 'hopcsharp: init database' })

-- navigation
vim.keymap.set('n', '<leader>hd', hopcsharp.hop_to_definition, { desc = 'hopcsharp: go to definition' })
vim.keymap.set('n', '<leader>hi', hopcsharp.hop_to_implementation, { desc = 'hopcsharp: go to implementation' })
vim.keymap.set('n', '<leader>hr', hopcsharp.hop_to_reference, { desc = 'hopcsharp: go to reference' })
vim.keymap.set('n', '<leader>ht', hopcsharp.get_type_hierarchy, { desc = 'hopcsharp: type hierarchy' })
