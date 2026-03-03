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

local keymap = vim.keymap

-- Toggle the quickfix list after populating
keymap.set('n', '<leader>q', function()
  require('quicker').toggle()
end, { desc = 'toggle quickfix list' })

-- Expand/collapse quickfix context from normal mode
keymap.set('n', '<leader>Qe', function()
  require('quicker').expand { before = 2, after = 2, add_to_existing = true }
end, { desc = 'expand quickfix context' })

keymap.set('n', '<leader>Qc', function()
  require('quicker').collapse()
end, { desc = 'collapse quickfix context' })

-- Refresh the quickfix list
keymap.set('n', '<leader>Qr', function()
  require('quicker').refresh()
end, { desc = 'refresh quickfix list' })
