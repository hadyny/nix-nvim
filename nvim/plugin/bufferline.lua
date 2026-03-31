if vim.g.did_load_bufferline_plugin then
  return
end
vim.g.did_load_bufferline_plugin = true

require('bufferline').setup {
  options = {
    mode = 'buffers',
    style_preset = require('bufferline').style_preset.default,
    themable = true,
    numbers = 'none',
    close_command = 'bdelete! %d',
    right_mouse_command = 'bdelete! %d',
    left_mouse_command = 'buffer %d',
    middle_mouse_command = nil,
    indicator = {
      icon = '▎',
      style = 'icon',
    },
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
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
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
  highlights = {
    fill = {
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
    background = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    tab = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    tab_selected = {
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
    },
    tab_separator = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    tab_separator_selected = {
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
    },
    tab_close = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    close_button = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    close_button_visible = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    close_button_selected = {
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
    },
    buffer_selected = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
    },
    numbers = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    numbers_visible = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    numbers_selected = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
    },
    diagnostic = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    diagnostic_visible = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    diagnostic_selected = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
    },
    hint = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
      sp = { attribute = 'fg', highlight = 'DiagnosticHint' },
    },
    hint_visible = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    hint_selected = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
      sp = { attribute = 'fg', highlight = 'DiagnosticHint' },
    },
    hint_diagnostic = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
      sp = { attribute = 'fg', highlight = 'DiagnosticHint' },
    },
    hint_diagnostic_visible = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    hint_diagnostic_selected = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
      sp = { attribute = 'fg', highlight = 'DiagnosticHint' },
    },
    info = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
      sp = { attribute = 'fg', highlight = 'DiagnosticInfo' },
    },
    info_visible = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    info_selected = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
      sp = { attribute = 'fg', highlight = 'DiagnosticInfo' },
    },
    info_diagnostic = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
      sp = { attribute = 'fg', highlight = 'DiagnosticInfo' },
    },
    info_diagnostic_visible = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    info_diagnostic_selected = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
      sp = { attribute = 'fg', highlight = 'DiagnosticInfo' },
    },
    warning = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
      sp = { attribute = 'fg', highlight = 'DiagnosticWarn' },
    },
    warning_visible = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    warning_selected = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
      sp = { attribute = 'fg', highlight = 'DiagnosticWarn' },
    },
    warning_diagnostic = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
      sp = { attribute = 'fg', highlight = 'DiagnosticWarn' },
    },
    warning_diagnostic_visible = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    warning_diagnostic_selected = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
      sp = { attribute = 'fg', highlight = 'DiagnosticWarn' },
    },
    error = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
      sp = { attribute = 'fg', highlight = 'DiagnosticError' },
    },
    error_visible = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    error_selected = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
      sp = { attribute = 'fg', highlight = 'DiagnosticError' },
    },
    error_diagnostic = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
      sp = { attribute = 'fg', highlight = 'DiagnosticError' },
    },
    error_diagnostic_visible = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    error_diagnostic_selected = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
      sp = { attribute = 'fg', highlight = 'DiagnosticError' },
    },
    modified = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    modified_visible = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    modified_selected = {
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
    },
    duplicate_selected = {
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
    },
    duplicate_visible = {
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    duplicate = {
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    separator_selected = {
      fg = { attribute = 'bg', highlight = 'Normal' },
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
    },
    separator_visible = {
      fg = { attribute = 'bg', highlight = 'Normal' },
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    separator = {
      fg = { attribute = 'bg', highlight = 'Normal' },
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    indicator_visible = {
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    indicator_selected = {
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
    },
    pick_selected = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLineSel' },
    },
    pick_visible = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    pick = {
      bold = true,
      italic = false,
      bg = { attribute = 'bg', highlight = 'TabLine' },
    },
    offset_separator = {
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
    trunc_marker = {
      bg = { attribute = 'bg', highlight = 'Normal' },
    },
  },
}

local map = vim.keymap.set

-- Navigate buffers
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
map('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
map('n', '<A-S-h>', '<cmd>BufferLineMovePrev<CR>', { desc = 'Move buffer left' })
map('n', '<A-S-l>', '<cmd>BufferLineMoveNext<CR>', { desc = 'Move buffer right' })

-- Go to buffer by position
map('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<CR>', { desc = 'Buffer 1' })
map('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<CR>', { desc = 'Buffer 2' })
map('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<CR>', { desc = 'Buffer 3' })
map('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<CR>', { desc = 'Buffer 4' })
map('n', '<leader>5', '<cmd>BufferLineGoToBuffer 5<CR>', { desc = 'Buffer 5' })
map('n', '<leader>6', '<cmd>BufferLineGoToBuffer 6<CR>', { desc = 'Buffer 6' })
map('n', '<leader>7', '<cmd>BufferLineGoToBuffer 7<CR>', { desc = 'Buffer 7' })
map('n', '<leader>8', '<cmd>BufferLineGoToBuffer 8<CR>', { desc = 'Buffer 8' })
-- <leader>9 reserved for 99.nvim

-- Close buffers
map('n', '<leader>bc', '<cmd>BufferLinePickClose<CR>', { desc = 'Close picked buffer' })
map('n', '<leader>bl', '<cmd>BufferLineCloseLeft<CR>', { desc = 'Close buffers left' })
map('n', '<leader>br', '<cmd>BufferLineCloseRight<CR>', { desc = 'Close buffers right' })
map('n', '<leader>bx', '<cmd>BufferLineCloseOthers<CR>', { desc = 'Close other buffers' })

-- Pick buffer
map('n', '<leader>bp', '<cmd>BufferLinePick<CR>', { desc = 'Pick buffer' })

-- Sort buffers
map('n', '<leader>bd', '<cmd>BufferLineSortByDirectory<CR>', { desc = 'Sort by directory' })
map('n', '<leader>bs', '<cmd>BufferLineSortByExtension<CR>', { desc = 'Sort by extension' })
