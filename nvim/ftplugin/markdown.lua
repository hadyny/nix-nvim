vim.bo.comments = ':---,:--'

local markdown_ls_cmd = 'marksman'

-- Check if marksman is available
if vim.fn.executable(markdown_ls_cmd) ~= 1 then
  return
end

local root_files = { '.marksman.toml', '.git' }

vim.lsp.start {
  name = 'marksman',
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
}
