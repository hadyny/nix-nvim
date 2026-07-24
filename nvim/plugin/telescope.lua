if vim.g.did_load_telescope_plugin then
  return
end
vim.g.did_load_telescope_plugin = true

local telescope = require('telescope')
local themes = require('telescope.themes')

telescope.setup {
  -- ivy theme: a full-width pane docked at the bottom (with preview), applied
  -- as the default so every picker (and frecency) uses it.
  defaults = themes.get_ivy(),
  extensions = {
    fzf = {},
    -- vim.ui.select popups appear at the cursor.
    ['ui-select'] = { themes.get_cursor() },
    frecency = {
      show_scores = true,
    },
  },
}

-- Native FZF sorter (telescope-fzf-native.nvim) for faster/fuzzier matching.
telescope.load_extension('fzf')
-- Route vim.ui.select through telescope (telescope-ui-select.nvim).
telescope.load_extension('ui-select')
-- Frequency + recency ranked files (telescope-frecency.nvim).
telescope.load_extension('frecency')

local builtin = require('telescope.builtin')

local map = vim.keymap.set

map('n', '<leader>fr', function()
  telescope.extensions.frecency.frecency { workspace = 'CWD' }
end, { desc = 'Recent files' })
map('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
map({ 'n', 'v', 'x' }, '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
map({ 'n', 'v', 'x' }, '<leader>/', builtin.live_grep, { desc = 'Grep' })
map({ 'n', 'v', 'x' }, '<leader><leader>', builtin.commands, { desc = 'Commands' })
