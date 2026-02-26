vim.bo.comments = ':---,:--'

local typescript_ls_cmd = 'vtsls'
local eslint_ls_cmd = 'vscode-eslint-language-server'
local tailwind_ls_cmd = 'tailwindcss-language-server'

-- Check if language servers are available
if
  vim.fn.executable(typescript_ls_cmd) ~= 1
  or vim.fn.executable(eslint_ls_cmd) ~= 1
  or vim.fn.executable(tailwind_ls_cmd) ~= 1
then
  return
end

-- vtsls

local vtsls_root_files = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }

vim.lsp.start {
  cmd = { 'vtsls', '--stdio' },
  init_options = {
    hostInfo = 'neovim',
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  root_dir = vim.fs.dirname(vim.fs.find(vtsls_root_files, { upward = true })[1]),
  -- root_dir = function(fname, bufnr)
  --   local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
  --   root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
  --     or vim.list_extend(root_markers, { '.git' })
  --   local deno_root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' })
  --   local deno_lock_root = vim.fs.root(bufnr, { 'deno.lock' })
  --   local project_root = vim.fs.root(bufnr, root_markers)
  --   if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
  --     return nil
  --   end
  --   if deno_root and (not project_root or #deno_root >= #project_root) then
  --     return nil
  --   end
  --   return project_root or vim.fn.getcwd()
  -- end,
}

-- eslint
-- local util = require('lspconfig.util')

local eslint_root_files = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }

local eslint_config_files = {
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc.json',
  'eslint.config.js',
  'eslint.config.mjs',
  'eslint.config.cjs',
  'eslint.config.ts',
  'eslint.config.mts',
  'eslint.config.cts',
}

vim.lsp.start {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
    'astro',
    'htmlangular',
  },
  workspace_required = true,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspEslintFixAll', function()
      client:request_sync('workspace/executeCommand', {
        command = 'eslint.applyAllFixes',
        arguments = {
          {
            uri = vim.uri_from_bufnr(bufnr),
            version = vim.lsp.util.buf_versions[bufnr],
          },
        },
      }, nil, bufnr)
    end, {})
  end,
  root_dir = vim.fs.dirname(vim.fs.find(eslint_root_files, { upward = true })[1]),

  -- root_dir = function(bufnr)
  --   -- The project root is where the LSP can be started from
  --   -- As stated in the documentation above, this LSP supports monorepos and simple projects.
  --   -- We select then from the project root, which is identified by the presence of a package
  --   -- manager lock file.
  --   local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
  --   -- Give the root markers equal priority by wrapping them in a table
  --   root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
  --     or vim.list_extend(root_markers, { '.git' })
  --
  --   -- exclude deno
  --   if vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', 'deno.lock' }) then
  --     return nil
  --   end
  --
  --   -- We fallback to the current working directory if no project root is found
  --   local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
  --
  --   -- We know that the buffer is using ESLint if it has a config file
  --   -- in its directory tree.
  --   --
  --   -- Eslint used to support package.json files as config files, but it doesn't anymore.
  --   -- We keep this for backward compatibility.
  --   local filename = vim.api.nvim_buf_get_name(bufnr)
  --   local eslint_config_files_with_package_json =
  --     util.insert_package_json(eslint_config_files, 'eslintConfig', filename)
  --   local is_buffer_using_eslint = vim.fs.find(eslint_config_files_with_package_json, {
  --     path = filename,
  --     type = 'file',
  --     limit = 1,
  --     upward = true,
  --     stop = vim.fs.dirname(project_root),
  --   })[1]
  --   if not is_buffer_using_eslint then
  --     return nil
  --   end
  --
  --   return project_root
  -- end,
  -- Refer to https://github.com/Microsoft/vscode-eslint#settings-options for documentation.
  settings = {
    validate = 'on',
    ---@diagnostic disable-next-line: assign-type-mismatch
    packageManager = nil,
    useESLintClass = false,
    experimental = {
      useFlatConfig = false,
    },
    codeActionOnSave = {
      enable = false,
      mode = 'all',
    },
    format = true,
    quiet = false,
    onIgnoredFiles = 'off',
    rulesCustomizations = {},
    run = 'onType',
    problems = {
      shortenToSingleLine = false,
    },
    -- nodePath configures the directory in which the eslint server should start its node_modules resolution.
    -- This path is relative to the workspace folder (root dir) of the server instance.
    nodePath = '',
    -- use the workspace folder location or the file location (if no workspace folder is open) as the working directory
    workingDirectory = { mode = 'auto' },
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = 'separateLine',
      },
      showDocumentation = {
        enable = true,
      },
    },
  },
  before_init = function(_, config)
    -- The "workspaceFolder" is a VSCode concept. It limits how far the
    -- server will traverse the file system when locating the ESLint config
    -- file (e.g., .eslintrc).
    local root_dir = config.root_dir

    if root_dir then
      config.settings = config.settings or {}
      config.settings.workspaceFolder = {
        uri = root_dir,
        name = vim.fn.fnamemodify(root_dir, ':t'),
      }

      -- Support flat config files
      -- They contain 'config' in the file name
      local flat_config_files = vim.tbl_filter(function(file)
        return file:match('config')
      end, eslint_config_files)

      for _, file in ipairs(flat_config_files) do
        local found_files = vim.fn.globpath(root_dir, file, true, true)

        -- Filter out files inside node_modules
        local filtered_files = {}
        for _, found_file in ipairs(found_files) do
          if string.find(found_file, '[/\\]node_modules[/\\]') == nil then
            table.insert(filtered_files, found_file)
          end
        end

        if #filtered_files > 0 then
          config.settings.experimental = config.settings.experimental or {}
          config.settings.experimental.useFlatConfig = true
          break
        end
      end

      -- Support Yarn2 (PnP) projects
      local pnp_cjs = root_dir .. '/.pnp.cjs'
      local pnp_js = root_dir .. '/.pnp.js'
      if type(config.cmd) == 'table' and (vim.uv.fs_stat(pnp_cjs) or vim.uv.fs_stat(pnp_js)) then
        config.cmd = vim.list_extend({ 'yarn', 'exec' }, config.cmd --[[@as table]])
      end
    end
  end,
  handlers = {
    ['eslint/openDoc'] = function(_, result)
      if result then
        vim.ui.open(result.url)
      end
      return {}
    end,
    ['eslint/confirmESLintExecution'] = function(_, result)
      if not result then
        return
      end
      return 4 -- approved
    end,
    ['eslint/probeFailed'] = function()
      vim.notify('ESLint probe failed.', vim.log.levels.WARN)
      return {}
    end,
    ['eslint/noLibrary'] = function()
      vim.notify('Unable to find ESLint library.', vim.log.levels.WARN)
      return {}
    end,
  },
}

-- tailwind

local tailwind_root_files = {
  -- Generic
  'tailwind.config.js',
  'tailwind.config.cjs',
  'tailwind.config.mjs',
  'tailwind.config.ts',
  'postcss.config.js',
  'postcss.config.cjs',
  'postcss.config.mjs',
  'postcss.config.ts',
  '.git',
}

vim.lsp.start {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  -- filetypes copied and adjusted from tailwindcss-intellisense
  filetypes = {
    -- html
    'aspnetcorerazor',
    'astro',
    'astro-markdown',
    'blade',
    'clojure',
    'django-html',
    'htmldjango',
    'edge',
    'eelixir', -- vim ft
    'elixir',
    'ejs',
    'erb',
    'eruby', -- vim ft
    'gohtml',
    'gohtmltmpl',
    'haml',
    'handlebars',
    'hbs',
    'html',
    'htmlangular',
    'html-eex',
    'heex',
    'jade',
    'leaf',
    'liquid',
    'markdown',
    'mdx',
    'mustache',
    'njk',
    'nunjucks',
    'php',
    'razor',
    'slim',
    'twig',
    -- css
    'css',
    'less',
    'postcss',
    'sass',
    'scss',
    'stylus',
    'sugarss',
    -- js
    'javascript',
    'javascriptreact',
    'reason',
    'rescript',
    'typescript',
    'typescriptreact',
    -- mixed
    'vue',
    'svelte',
    'templ',
  },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
      },
      classAttributes = {
        'class',
        'className',
        'class:list',
        'classList',
        'ngClass',
      },
      includeLanguages = {
        eelixir = 'html-eex',
        elixir = 'phoenix-heex',
        eruby = 'erb',
        heex = 'phoenix-heex',
        htmlangular = 'html',
        templ = 'html',
      },
    },
  },
  before_init = function(_, config)
    if not config.settings then
      config.settings = {}
    end
    if not config.settings.editor then
      config.settings.editor = {}
    end
    if not config.settings.editor.tabSize then
      config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
    end
  end,
  workspace_required = true,
  root_dir = vim.fs.dirname(vim.fs.find(tailwind_root_files, { upward = true })[1]),
  -- root_dir = function(bufnr)
  --     local root_files = {
  --       -- Generic
  --       'tailwind.config.js',
  --       'tailwind.config.cjs',
  --       'tailwind.config.mjs',
  --       'tailwind.config.ts',
  --       'postcss.config.js',
  --       'postcss.config.cjs',
  --       'postcss.config.mjs',
  --       'postcss.config.ts',
  --       -- Django
  --       'theme/static_src/tailwind.config.js',
  --       'theme/static_src/tailwind.config.cjs',
  --       'theme/static_src/tailwind.config.mjs',
  --       'theme/static_src/tailwind.config.ts',
  --       'theme/static_src/postcss.config.js',
  --       -- Fallback for tailwind v4, where tailwind.config.* is not required anymore
  --       '.git',
  --     }
  --     local fname = vim.api.nvim_buf_get_name(bufnr)
  --     root_files = util.insert_package_json(root_files, 'tailwindcss', fname)
  --     root_files = util.root_markers_with_field(root_files, { 'mix.lock', 'Gemfile.lock' }, 'tailwind', fname)
  --     return vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1])
  --   end,
}

-- graphql

local graphql_root_files = { '.graphqlrc*', '.graphql.config.*', 'graphql.config.*' }

vim.lsp.start {
  cmd = { 'graphql-lsp', 'server', '-m', 'stream' },
  filetypes = { 'graphql', 'typescriptreact', 'javascriptreact' },
  root_dir = vim.fs.dirname(vim.fs.find(graphql_root_files, { upward = true })[1]),
  -- root_dir = function(bufnr)
  --     local fname = vim.api.nvim_buf_get_name(bufnr)
  --     return util.root_pattern('.graphqlrc*', '.graphql.config.*', 'graphql.config.*')(fname)
  --   end,
}
