if vim.g.did_load_99_plugin then
  return
end
vim.g.did_load_99_plugin = true

local _99 = require('99')

local cwd = vim.uv.cwd()
local basename = vim.fs.basename(cwd)

_99.setup {
  provider = _99.Providers.ClaudeCodeProvider,
  completion = {
    source = 'blink',
  },
  logger = {
    level = _99.INFO,
    path = '/tmp/' .. basename .. '.99.debug',
    print_on_error = true,
  },
  md_files = {
    'AGENT.md',
  },
}

local map = vim.keymap.set

map('v', '<leader>9v', function()
  _99.visual()
end, { desc = '99: Visual send' })

map('n', '<leader>9x', function()
  _99.stop_all_requests()
end, { desc = '99: Cancel requests' })

map('n', '<leader>9s', function()
  _99.search()
end, { desc = '99: Search' })

map('n', '<leader>9o', function()
  _99.open()
end, { desc = '99: Open results' })

map('n', '<leader>9l', function()
  _99.view_logs()
end, { desc = '99: View logs' })
