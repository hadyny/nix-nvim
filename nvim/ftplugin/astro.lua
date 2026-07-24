if vim.fn.executable('astro-ls') ~= 1 then
  return
end

local astro_root_files = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' }
local root_dir = vim.fs.dirname(vim.fs.find(astro_root_files, { upward = true })[1])

-- astro-ls hard-fails without init_options.typescript.tsdk. Mirror lspconfig's
-- behaviour: search upward for a project-local node_modules/typescript/lib,
-- and fall back to the Nix-installed typescript package via `tsc` on PATH.
local function find_tsdk()
  local local_sdk = vim.fs.find('node_modules/typescript/lib', {
    upward = true,
    type = 'directory',
    path = root_dir,
  })[1]
  if local_sdk then
    return local_sdk
  end

  local tsc = vim.fn.resolve(vim.fn.exepath('tsc'))
  if tsc == '' then
    return nil
  end
  local nix_sdk = tsc:gsub('/bin/tsc$', '/lib/node_modules/typescript/lib')
  if nix_sdk ~= tsc and vim.uv.fs_stat(nix_sdk) then
    return nix_sdk
  end
  return nil
end

local tsdk = find_tsdk()

vim.lsp.start {
  name = 'astro',
  cmd = { 'astro-ls', '--stdio' },
  -- astro-ls internally `require`s 'typescript' before consulting init_options.
  -- Nix installs each npm package as its own derivation, so Node's resolver
  -- can't find typescript by walking up node_modules. Point NODE_PATH at the
  -- node_modules dir that contains typescript/ alongside the tsdk option.
  cmd_env = tsdk and { NODE_PATH = tsdk:gsub('/typescript/lib$', '') } or nil,
  filetypes = { 'astro' },
  root_dir = root_dir,
  init_options = {
    typescript = {
      tsdk = tsdk,
    },
  },
  capabilities = require('user.lsp').make_client_capabilities(),
}

-- eslint + tailwindcss also attach here: they list 'astro' in their filetypes
-- (nvim/lsp/{eslint,tailwindcss}.lua) and are enabled in nvim/plugin/lsp.lua.
-- astro-ls itself stays a bespoke start because its NODE_PATH/tsdk are computed
-- per project above, which the static vim.lsp.config model can't express.
