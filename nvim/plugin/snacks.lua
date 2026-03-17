if vim.g.did_load_snacks_plugin then
  return
end
vim.g.did_load_snacks_plugin = true

require('snacks').setup {
  animate = { enabled = true },
  explorer = {
    enabled = true,
    replace_netrw = true,
  },
  git = { enabled = true },
  gitbrowse = { enabled = true },
  indent = {
    enabled = true,
    only_scope = true,
    animate = { enabled = true },
  },
  input = { enabled = true },
  picker = {
    enabled = true,
    sources = {
      explorer = {
        layout = {
          layout = {
            position = 'right',
          },
        },
      },
    },
  },
  rename = { enabled = true },
  statuscolumn = { enabled = true },
}

local map = vim.keymap.set

-- Explorer
map('n', '<leader>e', function()
  Snacks.explorer()
end, { desc = 'Explorer' })

-- Find
map('n', '<leader><leader>', function()
  Snacks.picker.smart()
end, { desc = 'Find files' })

map({ 'n', 'v', 'x' }, '<leader>,', function()
  Snacks.picker.buffers()
end, { desc = 'Find buffers' })

map({ 'n', 'v', 'x' }, '<leader>/', function()
  Snacks.picker.grep()
end, { desc = 'Grep' })

map({ 'n', 'v', 'x' }, '<leader>:', function()
  Snacks.picker.command_history()
end, { desc = 'Command history' })

map({ 'n', 'v', 'x' }, '<C-f>', function()
  Snacks.picker.lines()
end, { desc = 'Search buffer' })

-- Git
map('n', '<leader>gb', function()
  Snacks.git.blame_line()
end, { desc = 'Git blame line' })

map({ 'n', 'v', 'x' }, '<leader>go', function()
  Snacks.gitBrowse()
end, { desc = 'Git browse online' })
