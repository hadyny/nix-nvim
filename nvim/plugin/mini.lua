if vim.g.did_load_mini_plugin then
  return
end
vim.g.did_load_mini_plugin = true

require('mini.pairs').setup()
require('mini.cursorword').setup { delay = 1000 }
local MiniIcons = require('mini.icons')
MiniIcons.setup()
MiniIcons.mock_nvim_web_devicons()
MiniIcons.tweak_lsp_kind()
require('mini.statusline').setup()

vim.o.completeopt = 'menu,preview,noselect,popup'

require('mini.completion').setup {
  set_vim_settings = false,
}
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local buftype = vim.bo.buftype
    if buftype == 'prompt' or buftype == 'nofile' then
      vim.b.minicompletion_disable = true
    end
  end,
})
require('mini.cmdline').setup()
local miniclue = require('mini.clue')
miniclue.setup {
  triggers = {
    -- Leader triggers
    { mode = { 'n', 'x' }, keys = '<Leader>' },

    -- `[` and `]` keys
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = { 'n', 'x' }, keys = 'g' },

    -- Marks
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },

    -- Registers
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = { 'n', 'x' }, keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
}
