if vim.g.did_load_lsp_plugin then
  return
end
vim.g.did_load_lsp_plugin = true

-- Capabilities shared by every server (blink.cmp completion, etc.). vim.lsp
-- deep-merges this '*' config under each per-server config in nvim/lsp/, so
-- individual servers no longer repeat make_client_capabilities().
vim.lsp.config('*', {
  capabilities = require('user.lsp').make_client_capabilities(),
})

-- Enable each server whose executable is on PATH. The config for `<name>` is
-- auto-loaded from nvim/lsp/<name>.lua on the runtimepath; enabling drives
-- autostart from each config's `filetypes` + `root_markers`.
--
-- astro is intentionally absent: it needs a per-buffer cmd_env (NODE_PATH) and
-- tsdk computed from each project, which the static config model can't express,
-- so it stays a bespoke starter in ftplugin/astro.lua.
local servers = {
  luals = 'lua-language-server',
  gopls = 'gopls',
  nixd = 'nixd',
  vtsls = 'vtsls',
  graphql = 'graphql-lsp',
  eslint = 'vscode-eslint-language-server',
  tailwindcss = 'tailwindcss-language-server',
  marksman = 'marksman',
}

for name, exe in pairs(servers) do
  if vim.fn.executable(exe) == 1 then
    vim.lsp.enable(name)
  end
end
