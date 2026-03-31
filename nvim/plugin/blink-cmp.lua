if vim.g.did_load_blink_cmp_plugin then
  return
end
vim.g.did_load_blink_cmp_plugin = true

vim.o.completeopt = 'menu,menuone,noselect'

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
    default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
    per_filetype = {
      cs = { 'lsp', 'path', 'snippets', 'buffer', 'easy-dotnet' },
    },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
      ['easy-dotnet'] = {
        name = 'easy-dotnet',
        enabled = true,
        module = 'easy-dotnet.completion.blink',
        score_offset = 10000,
        async = true,
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
