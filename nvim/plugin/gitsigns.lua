if vim.g.did_load_gitsigns_plugin then
  return
end
vim.g.did_load_gitsigns_plugin = true

require('gitsigns').setup {
  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local map = vim.keymap.set

    -- Navigation
    map('n', '[h', function()
      gs.nav_hunk('prev')
    end, { buffer = bufnr, desc = 'Previous hunk' })

    map('n', ']h', function()
      gs.nav_hunk('next')
    end, { buffer = bufnr, desc = 'Next hunk' })

    -- Diff
    map('n', '<leader>hd', gs.diffthis, { buffer = bufnr, desc = 'Diff this' })

    -- Preview
    map('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })

    -- Reset
    map('n', '<leader>hR', gs.reset_buffer, { buffer = bufnr, desc = 'Reset buffer' })
    map('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = 'Reset hunk' })
    map('v', '<leader>hr', function()
      gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
    end, { buffer = bufnr, desc = 'Reset hunk' })

    -- Stage
    map('n', '<leader>hS', gs.stage_buffer, { buffer = bufnr, desc = 'Stage buffer' })
    map('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
    map('v', '<leader>hs', function()
      gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
    end, { buffer = bufnr, desc = 'Stage hunk' })

    -- Blame
    map('n', '<leader>gb', function()
      gs.blame_line { full = true }
    end, { buffer = bufnr, desc = 'Git blame line' })

    -- Toggle
    map('n', '<leader>htd', gs.toggle_deleted, { buffer = bufnr, desc = 'Toggle deleted' })

    -- Undo
    map('n', '<leader>hu', gs.undo_stage_hunk, { buffer = bufnr, desc = 'Undo stage hunk' })
  end,
}
