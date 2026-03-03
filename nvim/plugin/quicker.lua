if vim.g.did_load_quicker_plugin then
  return
end
vim.g.did_load_quicker_plugin = true

require('quicker').setup {
  opts = {
    winfixheight = false,
  },
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
}

local keymap = vim.keymap

-- Toggle the quickfix list after populating
keymap.set('n', '<leader>q', function()
  vim.diagnostic.setqflist()
  require('quicker').toggle()
end, { desc = 'toggle quickfix list' })

-- Expand/collapse quickfix context from normal mode
keymap.set('n', '<leader>qe', function()
  require('quicker').expand { before = 2, after = 2, add_to_existing = true }
end, { desc = 'expand quickfix context' })

keymap.set('n', '<leader>qc', function()
  require('quicker').collapse()
end, { desc = 'collapse quickfix context' })

-- Refresh the quickfix list
keymap.set('n', '<leader>qr', function()
  require('quicker').refresh()
end, { desc = 'refresh quickfix list' })
