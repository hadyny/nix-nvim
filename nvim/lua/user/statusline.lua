local icons = require('user.icons')

local hl = function(group)
  return vim.api.nvim_get_hl(0, {
    name = group,
    link = false,
    create = false,
  })
end

local sl_hl = function(group)
  return '%#' .. group .. '#'
end

local highlight_icon = function(icon)
  return sl_hl(icon.group) .. icon.symbol .. sl_hl('StatusLine')
end

local set_hl_groups = function()
  local base = hl('StatusLine')

  for group, opts in pairs {
    ModeNormal = { fg = base.bg, bg = hl('StatusLine').fg },
    ModePending = { fg = base.bg, bg = hl('Comment').fg },
    ModeVisual = { fg = base.bg, bg = hl('SpecialKey').fg },
    ModeInsert = { fg = base.bg, bg = hl('String').fg },
    ModeCommand = { fg = base.bg, bg = hl('Number').fg },
    ModeReplace = { fg = base.bg, bg = hl('Constant').fg },
    Bold = { fg = base.fg, bg = base.bg, bold = true },
    Dim = { fg = hl('LineNr').fg, bg = base.bg },
  } do
    group = 'StatusLine' .. group
    vim.api.nvim_set_hl(0, group, opts)
    opts.fg, opts.bg = opts.bg, opts.fg
    vim.api.nvim_set_hl(0, group .. 'Inverted', opts)
  end
end

-- Compile and apply our custom highlights
set_hl_groups()

-- Re-compile statusline colours when the colorscheme changes
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('my_statusline', {}),
  desc = 'Re-apply statusline highlights on colorscheme change',
  callback = set_hl_groups,
})

local diagnostic_component = function()
  return vim.diagnostic.status(0):gsub('%w+:', ' %0', 1):gsub('(:%d+)%%', '%1 %%')
end

local git_component = function()
  local head = vim.b.gitsigns_head
  if not head or head == '' then
    return
  end

  local component = highlight_icon(icons.misc.branch) .. ' ' .. sl_hl('StatusLine') .. head

  local n_hunks = #(require('gitsigns').get_hunks(0) or {})
  if n_hunks > 0 then
    local s = n_hunks == 1 and '' or 's'
    component = component .. sl_hl('StatusLineDimItalic') .. string.format(' (%d hunk%s)', n_hunks, s)
  end

  return component
end

local file_component = function(active)
  local devicons = require('nvim-web-devicons')

  local buftype = vim.bo.buftype
  local ft = vim.bo.filetype

  local buf_path = vim.api.nvim_buf_get_name(0)
  local buf_name = vim.fn.fnamemodify(buf_path, ':t')
  local buf_ext = vim.fn.fnamemodify(buf_path, ':e')

  if ft == '' and buf_path == '' then
    return ''
  end

  local icon = (icons.ft[ft] or {}).symbol
  local icon_hl = (icons.ft[ft] or {}).group

  if not icon then
    icon, icon_hl = devicons.get_icon(buf_name, buf_ext)
  end

  if not icon then
    icon, icon_hl = devicons.get_icon_by_filetype(ft, { default = true })
  end

  local display_name = buf_name == '' and buf_path or buf_name

  if buftype == 'terminal' then
    if display_name:match('^zsh') then
      icon = icons.misc.terminal.symbol
      icon_hl = icons.misc.terminal.group
    elseif display_name:match('^claude') or display_name:match('^opencode') or display_name:match('^copilot') then
      icon = icons.misc.robot.symbol
      icon_hl = icons.misc.robot.group
    elseif display_name:match('^python ?') then
      icon, icon_hl = devicons.get_icon_by_filetype('python', { default = true })
    end
  end

  local name_hl = active and 'StatusLineBold' or 'StatusLineDim'

  return ' ' .. sl_hl(icon_hl) .. icon .. ' ' .. sl_hl(name_hl) .. display_name
end

local mode_component = function()
  -- Note: termcodes \19 and \22 are ^S and ^V
  ---- stylua: ignore
  local mode_settings = {
    ['n'] = { name = 'NORMAL', hl = 'Normal' },
    ['no'] = { name = 'OP-PENDING', hl = 'Pending' },
    ['nov'] = { name = 'OP-PENDING', hl = 'Pending' },
    ['noV'] = { name = 'OP-PENDING', hl = 'Pending' },
    ['no\22'] = { name = 'OP-PENDING', hl = 'Pending' },
    ['niI'] = { name = 'NORMAL', hl = 'Normal' },
    ['niR'] = { name = 'NORMAL', hl = 'Normal' },
    ['niV'] = { name = 'NORMAL', hl = 'Normal' },
    ['nt'] = { name = 'NORMAL', hl = 'Normal' },
    ['ntT'] = { name = 'NORMAL', hl = 'Normal' },
    ['v'] = { name = 'VISUAL', hl = 'Visual' },
    ['vs'] = { name = 'VISUAL', hl = 'Visual' },
    ['V'] = { name = 'V-LINE', hl = 'Visual' },
    ['Vs'] = { name = 'V-LINE', hl = 'Visual' },
    ['\22'] = { name = 'V-BLOCK', hl = 'Visual' },
    ['\22s'] = { name = 'V-BLOCK', hl = 'Visual' },
    ['s'] = { name = 'SELECT', hl = 'Insert' },
    ['S'] = { name = 'S-LINE', hl = 'Normal' },
    ['\19'] = { name = 'S-BLOCK', hl = 'Normal' },
    ['i'] = { name = 'INSERT', hl = 'Insert' },
    ['ic'] = { name = 'INSERT', hl = 'Insert' },
    ['ix'] = { name = 'INSERT', hl = 'Insert' },
    ['R'] = { name = 'REPLACE', hl = 'Replace' },
    ['Rc'] = { name = 'REPLACE', hl = 'Replace' },
    ['Rx'] = { name = 'REPLACE', hl = 'Replace' },
    ['Rv'] = { name = 'V-REPLACE', hl = 'Replace' },
    ['Rvc'] = { name = 'V-REPLACE', hl = 'Replace' },
    ['Rvx'] = { name = 'V-REPLACE', hl = 'Replace' },
    ['c'] = { name = 'COMMAND', hl = 'Command' },
    ['cv'] = { name = 'EX', hl = 'Command' },
    ['ce'] = { name = 'EX', hl = 'Command' },
    ['r'] = { name = 'REPLACE', hl = 'Normal' },
    ['rm'] = { name = 'MORE', hl = 'Normal' },
    ['r?'] = { name = 'CONFIRM', hl = 'Normal' },
    ['!'] = { name = 'SHELL', hl = 'Normal' },
    ['t'] = { name = 'TERMINAL', hl = 'Command' },
  }

  local mode = mode_settings[vim.fn.mode()] or {}

  return table.concat {
    '%#StatuslineMode' .. mode.hl .. 'Inverted' .. '#',
    '%#StatuslineMode' .. mode.hl .. '# ' .. mode.name .. ' ',
    '%#StatuslineMode' .. mode.hl .. 'Inverted' .. '#',
  }
end

return {
  render = function()
    local active_win = vim.fn.win_getid()
    local status_win = tonumber(vim.g.actual_curwin)

    if status_win ~= active_win then
      return table.concat { file_component(false) }
    end

    return table.concat {
      mode_component(),
      file_component(true),
      '%=',
      diagnostic_component(),
      git_component(),
    }
  end,
}
