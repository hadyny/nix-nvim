if vim.g.did_load_keymaps_plugin then
  return
end
vim.g.did_load_keymaps_plugin = true

local keymap = vim.keymap
local diagnostic = vim.diagnostic
local severity = diagnostic.severity

-- ── Helpers ──────────────────────────────────────────────────────────

local function try_fallback_notify(opts)
  local success, _ = pcall(opts.try)
  if success then
    return
  end
  success, _ = pcall(opts.fallback)
  if success then
    return
  end
  vim.notify(opts.notify, vim.log.levels.INFO)
end

local function toggle_diagnostics()
  local bufnr = vim.api.nvim_get_current_buf()
  if diagnostic.is_enabled { bufnr = bufnr } then
    diagnostic.enable(false, { bufnr = bufnr })
  else
    diagnostic.enable(true, { bufnr = bufnr })
  end
end

local function toggle_spell_check()
  vim.opt.spell = not vim.o.spell
end

local function toggle_treesitter_folding()
  if vim.wo.foldmethod == 'expr' and vim.wo.foldexpr:match('treesitter') then
    vim.wo.foldmethod = 'manual'
    vim.wo.foldexpr = ''
    vim.wo.foldcolumn = '0'
    vim.notify('Treesitter folding disabled', vim.log.levels.INFO)
  else
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldcolumn = 'auto:9'
    vim.wo.foldtext = 'v:lua.vim.treesitter.foldtext()'
    vim.wo.foldlevel = 99
    vim.notify('Treesitter folding enabled', vim.log.levels.INFO)
  end
end

-- ── General ──────────────────────────────────────────────────────────

-- Clear search highlight
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Better visual indent (stay in visual mode)
keymap.set('v', '<', '<gv', { desc = 'Indent left' })
keymap.set('v', '>', '>gv', { desc = 'Indent right' })

-- Move lines up/down
keymap.set('n', '<A-j>', '<cmd>m .+1<CR>==', { desc = 'Move line down' })
keymap.set('n', '<A-k>', '<cmd>m .-2<CR>==', { desc = 'Move line up' })
keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Window navigation
keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Terminal
keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Switch to normal mode' })
keymap.set('t', '<C-Esc>', '<Esc>', { desc = 'Send Esc to terminal' })

-- Command mode: expand to current buffer's directory
keymap.set('c', '%%', function()
  if vim.fn.getcmdtype() == ':' then
    return vim.fn.expand('%:h') .. '/'
  else
    return '%%'
  end
end, { expr = true, desc = "Expand to buffer's directory" })

-- ── Buffers (b) ──────────────────────────────────────────────────────

keymap.set('n', '[b', vim.cmd.bprevious, { silent = true, desc = 'Previous buffer' })
keymap.set('n', ']b', vim.cmd.bnext, { silent = true, desc = 'Next buffer' })
keymap.set('n', '[B', vim.cmd.bfirst, { silent = true, desc = 'First buffer' })
keymap.set('n', ']B', vim.cmd.blast, { silent = true, desc = 'Last buffer' })

-- ── Diagnostics (d) ─────────────────────────────────────────────────

keymap.set('n', '<leader>dk', function()
  local _, winid = diagnostic.open_float { scope = 'line' }
  if not winid then
    vim.notify('no diagnostics found', vim.log.levels.INFO)
    return
  end
  vim.api.nvim_win_set_config(winid or 0, { focusable = true })
end, { desc = 'Diagnostics floating window' })

keymap.set('n', '<leader>ds', function()
  diagnostic.setqflist()
end, { desc = 'Diagnostics to quickfix' })


keymap.set('n', '[d', function()
  diagnostic.jump { count = -1 }
end, { desc = 'Previous diagnostic' })

keymap.set('n', ']d', function()
  diagnostic.jump { count = 1 }
end, { desc = 'Next diagnostic' })

keymap.set('n', '[e', function()
  diagnostic.jump { count = -1, severity = severity.ERROR }
end, { desc = 'Previous error' })

keymap.set('n', ']e', function()
  diagnostic.jump { count = 1, severity = severity.ERROR }
end, { desc = 'Next error' })

-- ── Close floating windows (f) ──────────────────────────────────────

keymap.set('n', '<leader>fq', function()
  vim.cmd('fclose!')
end, { silent = true, desc = 'Close floating windows' })

-- ── Location list (l) ───────────────────────────────────────────────

keymap.set('n', '[l', function()
  try_fallback_notify {
    try = vim.cmd.lprev,
    fallback = vim.cmd.llast,
    notify = 'Location list is empty!',
  }
end, { silent = true, desc = 'Previous loclist entry' })

keymap.set('n', ']l', function()
  try_fallback_notify {
    try = vim.cmd.lnext,
    fallback = vim.cmd.lfirst,
    notify = 'Location list is empty!',
  }
end, { silent = true, desc = 'Next loclist entry' })

keymap.set('n', '[L', vim.cmd.lfirst, { silent = true, desc = 'First loclist entry' })
keymap.set('n', ']L', vim.cmd.llast, { silent = true, desc = 'Last loclist entry' })

-- ── Save (w) ────────────────────────────────────────────────────────

keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })

-- ── Toggle (t) ──────────────────────────────────────────────────────

keymap.set('n', '<leader>tD', toggle_diagnostics, { desc = 'Toggle buffer diagnostics' })
keymap.set('n', '<leader>tf', toggle_treesitter_folding, { desc = 'Toggle treesitter folding' })
keymap.set('n', '<leader>ts', toggle_spell_check, { desc = 'Toggle spellcheck' })

-- ── Git (g) ──────────────────────────────────────────────────────────

keymap.set('n', '<leader>gC', function()
  vim.cmd('terminal koji')
end, { desc = 'Commit with koji' })

-- ── Close buffer (x) ───────────────────────────────────────────────

keymap.set('n', '<leader>x', '<cmd>bdelete<CR>', { desc = 'Close buffer' })

-- ── Yank/Paste (y/p) ───────────────────────────────────────────────

keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p', { desc = 'Paste from clipboard' })
keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y', { desc = 'Yank to clipboard' })
keymap.set({ 'n', 'v', 'x' }, '<leader>Y', '"+yy', { desc = 'Yank line to clipboard' })
keymap.set('i', '<C-p>', '<C-r><C-p>+', { desc = 'Paste from clipboard (insert)' })
