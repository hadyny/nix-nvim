if vim.g.did_load_bufferline_plugin then
  return
end
vim.g.did_load_bufferline_plugin = true

-- Ensure mini.icons is set up to provide file type icons
local has_mini_icons = pcall(require, 'mini.icons')
if has_mini_icons then
  require('mini.icons').mock_nvim_web_devicons()
end

vim.opt.termguicolors = true

require('bufferline').setup {
  options = {
    mode = 'buffers', -- set to "tabs" to only show tabpages instead
    style_preset = require('bufferline').style_preset.default,
    themable = true,
    numbers = 'none', -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string
    close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
    right_mouse_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
    left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    indicator = {
      icon = '▎', -- this should be omitted if indicator style is not 'icon'
      style = 'icon', -- | 'underline' | 'none',
    },
    buffer_close_icon = '󰅖',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    tab_size = 18,
    diagnostics = 'nvim_lsp', -- | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match('error') and ' ' or ' '
      return ' ' .. icon .. count
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        text_align = 'center', -- | "left" | "right"
        separator = true,
      },
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = 'slope', -- | "slant" | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    hover = {
      enabled = true,
      delay = 200,
      reveal = { 'close' },
    },
    sort_by = 'insert_after_current', -- | 'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs'
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
    -- buffer_visible = {
    --   bg = { attribute = 'bg', highlight = 'TabLine' },
    -- },
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

-- Keymaps for bufferline
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Navigate buffers
map('n', '<S-l>', '<Cmd>BufferLineCycleNext<CR>', opts)
map('n', '<S-h>', '<Cmd>BufferLineCyclePrev<CR>', opts)

-- Move buffers
map('n', '<A-S-l>', '<Cmd>BufferLineMoveNext<CR>', opts)
map('n', '<A-S-h>', '<Cmd>BufferLineMovePrev<CR>', opts)

-- Go to buffer in position
map('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', opts)
map('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', opts)
map('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', opts)
map('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', opts)
map('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', opts)
map('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', opts)
map('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', opts)
map('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', opts)
map('n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', opts)

-- Pick buffer
map('n', '<leader>bp', '<Cmd>BufferLinePick<CR>', opts)

-- Close buffers
map('n', '<leader>bc', '<Cmd>BufferLinePickClose<CR>', opts)
map('n', '<leader>bx', '<Cmd>BufferLineCloseOthers<CR>', opts)
map('n', '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', opts)
map('n', '<leader>br', '<Cmd>BufferLineCloseRight<CR>', opts)

-- Sort buffers
map('n', '<leader>bs', '<Cmd>BufferLineSortByExtension<CR>', opts)
map('n', '<leader>bd', '<Cmd>BufferLineSortByDirectory<CR>', opts)
