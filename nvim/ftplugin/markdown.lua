vim.bo.comments = ':---,:--'

local markdown_ls_cmd = 'marksman'

-- Check if marksman is available
if vim.fn.executable(markdown_ls_cmd) ~= 1 then
  return
end

vim.lsp.start {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_markers = { '.marksman.toml', '.git' },
}
