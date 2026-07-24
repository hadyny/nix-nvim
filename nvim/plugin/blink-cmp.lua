if vim.g.did_load_blink_cmp_plugin then
  return
end
vim.g.did_load_blink_cmp_plugin = true

-- blink.cmp manages 'completeopt' itself; setting it manually here can fight
-- blink's menu behaviour, so leave it to the plugin.

require('blink.cmp').setup {
  keymap = { preset = 'super-tab' },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
    kind_icons = {
      Class = '󰠱',
      Color = '󰏘',
      Constant = '󰏿',
      Constructor = '',
      Enum = '',
      EnumMember = '',
      Event = '',
      Field = '󰜢',
      File = '󰈙',
      Folder = '󰉋',
      Function = '󰊕',
      Interface = '',
      Keyword = '󰌋',
      Method = '󰆧',
      Module = '',
      Operator = '󰆕',
      Property = '󰜢',
      Reference = '󰈇',
      Snippet = '',
      Struct = '󰙅',
      Text = '󰉿',
      TypeParameter = '',
      Unit = '󰑭',
      Value = '󰎠',
      Variable = '󰀫',
    },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    per_filetype = {
      cs = { 'lsp', 'path', 'snippets', 'buffer', 'easy-dotnet' },
      org = { 'orgmode', 'path', 'snippets', 'buffer' },
    },
    providers = {
      ['easy-dotnet'] = {
        name = 'easy-dotnet',
        enabled = true,
        module = 'easy-dotnet.completion.blink',
        score_offset = 10000,
        async = true,
      },
      ['orgmode'] = {
        name = 'Orgmode',
        module = 'orgmode.org.autocompletion.blink',
        fallbacks = { 'buffer' },
      },
    },
  },

  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
    menu = {
      draw = {
        treesitter = { 'lsp' },
        columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
    ghost_text = {
      enabled = true,
    },
  },

  signature = { enabled = true },
}
