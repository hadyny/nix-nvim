if vim.g.did_load_bufferline_plugin then
  return
end
vim.g.did_load_bufferline_plugin = true

require('bufferline').setup {
  options = {
    mode = 'buffers',
    themable = true,
    numbers = 'none',
    close_command = 'bdelete! %d',
    right_mouse_command = 'bdelete! %d',
    left_mouse_command = 'buffer %d',
    middle_mouse_command = nil,
    buffer_close_icon = '󰅖',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15,
    truncate_names = true,
    tab_size = 18,
    diagnostics = 'nvim_lsp',
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level)
      local icon = level:match('error') and ' ' or ' '
      return ' ' .. icon .. count
    end,
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        text_align = 'center',
        separator = true,
      },
    },
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true,
    persist_buffer_sort = true,
    move_wraps_at_ends = false,
    separator_style = 'slope',
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { 'close' },
    },
    sort_by = 'insert_after_current',
  },
}

local map = vim.keymap.set

-- Navigate buffers
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { silent = true, desc = 'Previous buffer' })
map('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { silent = true, desc = 'Next buffer' })
map('n', '<A-S-h>', '<cmd>BufferLineMovePrev<CR>', { silent = true, desc = 'Move buffer left' })
map('n', '<A-S-l>', '<cmd>BufferLineMoveNext<CR>', { silent = true, desc = 'Move buffer right' })

-- Go to buffer by position
map('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<CR>', { silent = true, desc = 'Buffer 1' })
map('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<CR>', { silent = true, desc = 'Buffer 2' })
map('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<CR>', { silent = true, desc = 'Buffer 3' })
map('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<CR>', { silent = true, desc = 'Buffer 4' })
map('n', '<leader>5', '<cmd>BufferLineGoToBuffer 5<CR>', { silent = true, desc = 'Buffer 5' })
map('n', '<leader>6', '<cmd>BufferLineGoToBuffer 6<CR>', { silent = true, desc = 'Buffer 6' })
map('n', '<leader>7', '<cmd>BufferLineGoToBuffer 7<CR>', { silent = true, desc = 'Buffer 7' })
map('n', '<leader>8', '<cmd>BufferLineGoToBuffer 8<CR>', { silent = true, desc = 'Buffer 8' })

-- Close buffers
map('n', '<leader>bc', '<cmd>BufferLinePickClose<CR>', { silent = true, desc = 'Close picked buffer' })
map('n', '<leader>bl', '<cmd>BufferLineCloseLeft<CR>', { silent = true, desc = 'Close buffers left' })
map('n', '<leader>br', '<cmd>BufferLineCloseRight<CR>', { silent = true, desc = 'Close buffers right' })
map('n', '<leader>bx', '<cmd>BufferLineCloseOthers<CR>', { silent = true, desc = 'Close other buffers' })

-- Pick buffer
map('n', '<leader>bp', '<cmd>BufferLinePick<CR>', { silent = true, desc = 'Pick buffer' })

-- Sort buffers
map('n', '<leader>bd', '<cmd>BufferLineSortByDirectory<CR>', { silent = true, desc = 'Sort by directory' })
map('n', '<leader>bs', '<cmd>BufferLineSortByExtension<CR>', { silent = true, desc = 'Sort by extension' })
