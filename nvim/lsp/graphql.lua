---@type vim.lsp.Config
-- graphql-language-service-cli. root_markers must be literal filenames (unlike
-- the old glob-style list, which vim.fs.find never actually matched), so the
-- common config filenames are spelled out plus `.git` as a project fallback.
return {
  cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
  filetypes = { 'graphql' },
  root_markers = {
    '.graphqlrc',
    '.graphqlrc.json',
    '.graphqlrc.yaml',
    '.graphqlrc.yml',
    '.graphqlrc.js',
    '.graphqlrc.ts',
    'graphql.config.js',
    'graphql.config.ts',
    'graphql.config.json',
    '.git',
  },
}
