vim.loader.enable()

-- Enable experimental UI2 (Neovim 0.12+). `vim._core` is a private, unstable
-- namespace, so guard it: a rename in a future 0.12.x should degrade quietly
-- rather than abort init this early.
pcall(function()
  require('vim._core.ui2').enable {}
end)

local cmd = vim.cmd
local opt = vim.o

-- <leader> key. Defaults to `\`. Some people prefer space.
-- The default leader is '\'. Some people prefer <space>. Uncomment this if you do, too.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- See :h <option> to see what the options do
-- (`path` gets '**' appended once under "Configure file search" below.)

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.showmatch = true -- Highlight matching parentheses, etc
opt.incsearch = true
opt.hlsearch = true
opt.confirm = true
opt.termguicolors = true

opt.spell = true
opt.spelllang = 'en_nz,en_gb,en'

opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.history = 2000
opt.nrformats = 'bin,hex' -- 'octal'
opt.undofile = true
opt.splitright = true
opt.splitbelow = true
opt.cmdheight = 0
opt.winborder = 'solid'

opt.scrolloff = 4
opt.sidescrolloff = 8
opt.mouse = 'a'

opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

opt.statusline = [[%{%v:lua.require('user.statusline').render()%}]]

vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden '
  .. "--glob '!node_modules' "
  .. "--glob '!.git' "
  .. "--glob '!dist' "
  .. "--glob '!build'"

-- Configure file search
vim.opt.path:append('**')
vim.opt.wildignore:append {
  '*/node_modules/*',
  '*/dist/*',
  '*/build/*',
  '*/target/*',
  '*/.git/*',
}
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'

-- Configure Neovim diagnostic messages

local function prefix_diagnostic(prefix, diagnostic)
  return string.format(prefix .. ' %s', diagnostic.message)
end

vim.diagnostic.config {
  virtual_text = {
    prefix = '',
    format = function(diagnostic)
      local severity = diagnostic.severity
      if severity == vim.diagnostic.severity.ERROR then
        return prefix_diagnostic('󰅚', diagnostic)
      end
      if severity == vim.diagnostic.severity.WARN then
        return prefix_diagnostic('⚠', diagnostic)
      end
      if severity == vim.diagnostic.severity.INFO then
        return prefix_diagnostic('ⓘ', diagnostic)
      end
      if severity == vim.diagnostic.severity.HINT then
        return prefix_diagnostic('󰌶', diagnostic)
      end
      return prefix_diagnostic('■', diagnostic)
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '⚠',
      [vim.diagnostic.severity.INFO] = 'ⓘ',
      [vim.diagnostic.severity.HINT] = '󰌶',
    },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = vim.o.winborder,
    source = 'if_many',
    header = '',
    prefix = '',
  },
}

local xeno = require('xeno')

xeno.color('amber', '#c9a15c')
xeno.color('violet', '#9483bf')
xeno.color('periwinkle', '#7d94c2')
xeno.color('phantom', '#A0DAA9')

xeno.theme('nocturnal', {
  min_contrast = 7.0,
  background = '#171a21',
  accent = '#5b7ca8',
  foreground = '#bcc6d4',
  properties = { contrast = 0.10, chroma = -0.30, variation = 0.15, lightness = -0.30 },
  -- Don't let xeno rewrite ~/.config/ghostty/config: it's a read-only
  -- home-manager symlink into the Nix store here, so the write always fails.
  integrations = { ghostty = { update_config = false } },
  highlights = {
    editor = {
      CursorLineNr = { fg = '@amber.100', bold = true },
      MatchParen = { fg = '@amber.100', bold = true },
    },
    syntax = {
      Comment = { fg = '@foreground.400', italic = true },
      Keyword = { fg = '@violet.300' },
      Conditional = { fg = '@violet.200' },
      Function = { fg = '@accent.300' },
      Type = { fg = '@accent.200' },
      String = { fg = '@amber.100' },
      Number = { fg = '@amber.100' },
      Boolean = { fg = '@amber.100' },
      Variable = { fg = '@foreground.300' },
      Property = { fg = '@phantom.50' },
      Parameter = { fg = '@phantom.300' },
      Operator = { fg = '@periwinkle.300' },
      Punctuation = { fg = '@foreground.400' },
      Tag = { fg = '@phantom.50' },
      Attribute = { fg = '@phantom.50' },
      ['@keyword'] = { link = 'Keyword' },
      ['@keyword.return'] = { link = 'Keyword' },
      ['@keyword.function'] = { link = 'Conditional' },
      ['@keyword.conditional'] = { link = 'Conditional' },
      ['@keyword.repeat'] = { link = 'Conditional' },
      ['@keyword.operator'] = { fg = '@periwinkle.300' },
      ['@keyword.import'] = { fg = '@periwinkle.400' },
      ['@function'] = { link = 'Function' },
      ['@function.builtin'] = { fg = '@accent.100', bold = true },
      ['@type'] = { link = 'Type' },
      ['@string'] = { link = 'String' },
      ['@string.escape'] = { fg = '@accent.100' },
      ['@number'] = { link = 'Number' },
      ['@boolean'] = { link = 'Boolean' },
      ['@constant'] = { fg = '@amber.100' },
      ['@constant.builtin'] = { fg = '@amber.100', bold = true },
      ['@variable'] = { link = 'Variable' },
      ['@variable.builtin'] = { fg = '@violet.200' },
      ['@variable.parameter'] = { link = 'Parameter' },
      ['@variable.member'] = { link = 'Property' },
      ['@property'] = { link = 'Property' },
      ['@constructor'] = { fg = '@foreground.400' },
      ['@operator'] = { link = 'Operator' },
      ['@punctuation'] = { link = 'Punctuation' },
      ['@punctuation.bracket'] = { link = 'Punctuation' },
      ['@punctuation.delimiter'] = { link = 'Punctuation' },
      ['@tag'] = { link = 'Tag' },
      ['@tag.builtin'] = { fg = '@phantom.100', bold = true },
      ['@tag.attribute'] = { fg = '@phantom.400' },
      ['@tag.delimiter'] = { link = 'Punctuation' },
      ['@attribute'] = { link = 'Attribute' },
      ['@attribute.builtin'] = { fg = '@phantom.100', bold = true },
      ['@lsp.type.variable'] = { link = '@variable' },
      ['@lsp.type.property'] = { link = '@property' },
      ['@lsp.type.parameter'] = { link = '@variable.parameter' },
      ['@lsp.type.function'] = { link = '@function' },
      ['@lsp.type.type'] = { link = '@type' },
      ['@lsp.type.decorator'] = { link = '@attribute' },
      ['@lsp.mod.declaration'] = { clear = true },
      ['@lsp.typemod.property.declaration'] = { link = '@property' },
    },
  },
})

vim.cmd.colorscheme('nocturnal')

-- Native plugins
cmd.filetype('plugin', 'indent', 'on')
cmd.packadd('cfilter') -- Allows filtering the quickfix list with :cfdo
cmd.packadd('nvim.undotree')
-- let sqlite.lua (which some plugins depend on) know where to find sqlite
vim.g.sqlite_clib_path = require('luv').os_getenv('LIBSQLITE')
