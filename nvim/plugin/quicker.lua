if vim.g.did_load_quicker_plugin then
  return
end
vim.g.did_load_quicker_plugin = true

require('quicker').setup {
  keys = {
    {
      '>',
      function()
        require('quicker').expand { before = 2, after = 2, add_to_existing = true }
      end,
      desc = 'Expand quickfix context',
    },
    {
      '<',
      function()
        require('quicker').collapse()
      end,
      desc = 'Collapse quickfix context',
    },
  },
  follow = {
    enabled = true,
  },
}

local map = vim.keymap.set

map('n', '<leader>qq', function()
  require('quicker').toggle()
end, { desc = 'Toggle quickfix' })

map('n', '<leader>qc', function()
  require('quicker').collapse()
end, { desc = 'Collapse quickfix context' })

map('n', '<leader>qe', function()
  require('quicker').expand { before = 2, after = 2, add_to_existing = true }
end, { desc = 'Expand quickfix context' })

map('n', '<leader>qr', function()
  require('quicker').refresh()
end, { desc = 'Refresh quickfix' })
