if vim.g.did_load_autocommands_plugin then
  return
end
vim.g.did_load_autocommands_plugin = true

local api = vim.api

local tempdirgroup = api.nvim_create_augroup('tempdir', { clear = true })
-- Do not set undofile for files in /tmp
api.nvim_create_autocmd('BufWritePre', {
  pattern = '/tmp/*',
  group = tempdirgroup,
  callback = function()
    vim.cmd.setlocal('noundofile')
  end,
})

-- Disable spell checking in terminal buffers
local nospell_group = api.nvim_create_augroup('nospell', { clear = true })
api.nvim_create_autocmd('TermOpen', {
  group = nospell_group,
  callback = function()
    vim.wo[0].spell = false
  end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- LSP
local keymap = vim.keymap

local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  local buf, _ = vim.lsp.util.preview_location(result[1])
  if buf then
    local cur_buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].filetype = vim.bo[cur_buf].filetype
  end
end

local function peek_definition()
  local params = vim.lsp.util.make_position_params(0, 'utf-16')
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

local function peek_type_definition()
  local params = vim.lsp.util.make_position_params(0, 'utf-16')
  return vim.lsp.buf_request(0, 'textDocument/typeDefinition', params, preview_location_callback)
end

--- Don't create a comment string when hitting <Enter> on a comment line
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('DisableNewLineAutoCommentString', {}),
  callback = function()
    vim.opt.formatoptions = vim.opt.formatoptions - { 'c', 'r', 'o' }
  end,
})

-- Enable treesitter highlighting and indenting when a file is opened
vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('TreesitterStart', { clear = true }),
  callback = function(args)
    local buf = args.buf
    -- Only start treesitter for normal buffers with a filetype
    if vim.bo[buf].buftype == '' and vim.bo[buf].filetype ~= '' then
      local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
      if lang and pcall(vim.treesitter.language.add, lang) then
        pcall(vim.treesitter.start, buf)
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Attach plugins

    vim.cmd.setlocal('signcolumn=yes')
    vim.bo[bufnr].bufhidden = 'hide'
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local function desc(description)
      return { noremap = true, silent = true, buffer = bufnr, desc = description }
    end

    -- Code actions
    keymap.set('n', '<M-CR>', vim.lsp.buf.code_action, desc('Code action'))

    -- Code lens
    keymap.set('n', '<leader>ll', vim.lsp.codelens.run, desc('Code lens run'))

    -- Document symbols
    keymap.set('n', '<leader>ld', vim.lsp.buf.document_symbol, desc('Document symbols'))

    -- Format
    keymap.set('n', '<leader>lf', function()
      vim.lsp.buf.format { async = true }
    end, desc('Format buffer'))

    -- Go to
    keymap.set('n', 'gD', vim.lsp.buf.declaration, desc('Go to declaration'))
    keymap.set('n', 'gd', vim.lsp.buf.definition, desc('Go to definition'))
    keymap.set('n', 'gi', vim.lsp.buf.implementation, desc('Go to implementation'))
    keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, desc('Go to type definition'))

    -- Hover and signature
    keymap.set('n', 'K', vim.lsp.buf.hover, desc('Hover'))
    keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, desc('Signature help'))

    -- Inlay hints
    if client and client.server_capabilities.inlayHintProvider then
      keymap.set('n', '<leader>lh', function()
        local current_setting = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
        vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
      end, desc('Toggle inlay hints'))
    end

    -- Peek
    keymap.set('n', '<leader>lpd', peek_definition, desc('Peek definition'))
    keymap.set('n', '<leader>lpt', peek_type_definition, desc('Peek type definition'))

    -- Rename
    keymap.set('n', '<leader>lr', vim.lsp.buf.rename, desc('Rename'))

    -- Workspace
    keymap.set('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, desc('Add workspace folder'))
    keymap.set('n', '<leader>lwl', function()
      vim.print(vim.lsp.buf.list_workspace_folders())
    end, desc('List workspace folders'))
    keymap.set('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, desc('Remove workspace folder'))
    keymap.set('n', '<leader>lws', vim.lsp.buf.workspace_symbol, desc('Workspace symbols'))
  end,
})
