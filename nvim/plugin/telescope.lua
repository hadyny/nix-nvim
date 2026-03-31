if vim.g.did_load_telescope_plugin then
  return
end
vim.g.did_load_telescope_plugin = true

local telescope = require('telescope')
local themes = require('telescope.themes')
local builtin = require('telescope.builtin')

telescope.setup {
  defaults = themes.get_dropdown {
    file_ignore_patterns = { 'node_modules', '.git/' },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    ['ui-select'] = {
      themes.get_cursor(),
    },
  },
}

telescope.load_extension('fzf')
telescope.load_extension('frecency')
telescope.load_extension('ui-select')

local map = vim.keymap.set

-- Find
map('n', '<leader><leader>', '<cmd>Telescope frecency<CR>', { desc = 'Frecent files' })
map('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
map({ 'n', 'v', 'x' }, '<leader>,', builtin.buffers, { desc = 'Find buffers' })
map({ 'n', 'v', 'x' }, '<leader>/', builtin.live_grep, { desc = 'Grep' })
map({ 'n', 'v', 'x' }, '<leader>:', builtin.command_history, { desc = 'Command history' })
map({ 'n', 'v', 'x' }, '<C-f>', function()
  builtin.current_buffer_fuzzy_find(themes.get_ivy())
end, { desc = 'Search buffer' })
