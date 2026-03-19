vim.treesitter.language.register('c_sharp', 'csharp')

local dap = require('dap')
local dapui = require('dapui')

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
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
  only_first_definition = true,
  all_references = false,
  clear_on_continue = false,
  display_callback = function(variable, _, _, _, options)
    if options.virt_text_pos == 'inline' then
      return ' = ' .. variable.value
    else
      return variable.name .. ' = ' .. variable.value
    end
  end,
  virt_text_pos = vim.fn.has('nvim-0.10') == 1 and 'inline' or 'eol',
  all_frames = false,
  virt_lines = false,
  virt_text_win_col = nil,
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

require('hopcsharp').setup {
  hop = {
    jump_on_quickfix = false,
    filter_entry_under_cursor = true,
  },
  database = {
    folder_path = vim.fn.stdpath('state'),
    buffer_size = 10000,
  },
}

local map = vim.keymap.set

-- C# hopcsharp
map('n', '<leader>csD', function()
  require('hopcsharp').init_database()
end, { desc = 'Hopcsharp init database' })

map('n', '<leader>csd', function()
  require('hopcsharp').hop_to_definition()
end, { desc = 'Hopcsharp go to definition' })

map('n', '<leader>csi', function()
  require('hopcsharp').hop_to_implementation()
end, { desc = 'Hopcsharp go to implementation' })

map('n', '<leader>csr', function()
  require('hopcsharp').hop_to_reference()
end, { desc = 'Hopcsharp go to reference' })

map('n', '<leader>cst', function()
  require('hopcsharp').get_type_hierarchy()
end, { desc = 'Hopcsharp type hierarchy' })

-- C# explorer
map('n', '<leader>cse', '<cmd>CSharpExplorer<CR>', { desc = 'C# explorer toggle' })
map('n', '<leader>csf', '<cmd>CSharpExplorerFindFile<CR>', { desc = 'C# explorer find file' })
map('n', '<leader>csR', '<cmd>CSharpExplorerRefresh<CR>', { desc = 'C# explorer refresh' })

-- Dotnet
map('n', '<leader>dn', '<cmd>Dotnet<CR>', { desc = 'Dotnet commands' })
map('n', '<leader>dr', '<cmd>Dotnet run<CR>', { desc = 'Dotnet run' })
map('n', '<leader>db', '<cmd>Dotnet build<CR>', { desc = 'Dotnet build' })
map('n', '<leader>dt', '<cmd>Dotnet test<CR>', { desc = 'Dotnet test' })
map('n', '<leader>dw', '<cmd>Dotnet watch<CR>', { desc = 'Dotnet watch' })
map('n', '<leader>dp', '<cmd>Dotnet project view<CR>', { desc = 'Dotnet project view' })
map('n', '<leader>do', '<cmd>Dotnet outdated<CR>', { desc = 'Dotnet outdated packages' })
map('n', '<leader>dT', '<cmd>Dotnet testrunner<CR>', { desc = 'Dotnet test runner' })

-- Debug
map('n', '<F5>', dap.continue, { desc = 'Debug: start/continue' })
map('n', '<F7>', dapui.toggle, { desc = 'Debug: toggle UI' })
map('n', '<F10>', dap.step_over, { desc = 'Debug: step over' })
map('n', '<F11>', dap.step_into, { desc = 'Debug: step into' })
map('n', '<F12>', dap.step_out, { desc = 'Debug: step out' })
map('n', '<leader>dB', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
map('n', '<leader>dq', function()
  dap.terminate()
  dap.clear_breakpoints()
end, { desc = 'Debug: terminate and clear' })
