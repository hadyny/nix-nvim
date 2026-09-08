require("xeno").setup({
  background = "#171a21",
  accent = "#5b7ca8",
  properties = {
    contrast = 0.1,
    variation = 0.1,
    chroma = -0.3,
    lightness = -0.3,
  },
  min_contrast = 7.00,
  transparent = false,
  foreground = "#bcc6d4",
  _custom_colors = {
    amber = "#c9a15c",
    violet = "#9483bf",
    phantom = "#A0DAA9",
    periwinkle = "#7d94c2"
  },
  highlights = {
    editor = {
      MatchParen = {
        fg = "@amber.100",
        bold = true
      },
      CursorLineNr = {
        fg = "@amber.100",
        bold = true
      }
    },
    syntax = {
      ["@tag.attribute"] = {
        fg = "@phantom.400"
      },
      Comment = {
        fg = "@foreground.400",
        italic = true
      },
      ["@attribute"] = {
        link = "Attribute"
      },
      ["@attribute.builtin"] = {
        fg = "@phantom.100",
        bold = true
      },
      Keyword = {
        fg = "@violet.300"
      },
      ["@lsp.type.property"] = {
        link = "@property"
      },
      Conditional = {
        fg = "@violet.200"
      },
      ["@lsp.type.function"] = {
        link = "@function"
      },
      Function = {
        fg = "@accent.300"
      },
      ["@lsp.type.decorator"] = {
        link = "@attribute"
      },
      Type = {
        fg = "@accent.200"
      },
      ["@lsp.typemod.property.declaration"] = {
        link = "@property"
      },
      String = {
        fg = "@amber.100"
      },
      Number = {
        fg = "@amber.100"
      },
      Boolean = {
        fg = "@amber.100"
      },
      Variable = {
        fg = "@foreground.300"
      },
      Property = {
        fg = "@phantom.50"
      },
      Parameter = {
        fg = "@phantom.300"
      },
      Operator = {
        fg = "@periwinkle.300"
      },
      Punctuation = {
        fg = "@foreground.400"
      },
      Tag = {
        fg = "@phantom.50"
      },
      Attribute = {
        fg = "@phantom.50"
      },
      ["@keyword"] = {
        link = "Keyword"
      },
      ["@keyword.return"] = {
        link = "Keyword"
      },
      ["@keyword.function"] = {
        link = "Conditional"
      },
      ["@keyword.conditional"] = {
        link = "Conditional"
      },
      ["@keyword.repeat"] = {
        link = "Conditional"
      },
      ["@keyword.operator"] = {
        fg = "@periwinkle.300"
      },
      ["@keyword.import"] = {
        fg = "@periwinkle.400"
      },
      ["@function"] = {
        link = "Function"
      },
      ["@function.builtin"] = {
        fg = "@accent.100",
        bold = true
      },
      ["@type"] = {
        link = "Type"
      },
      ["@string"] = {
        link = "String"
      },
      ["@string.escape"] = {
        fg = "@accent.100"
      },
      ["@number"] = {
        link = "Number"
      },
      ["@boolean"] = {
        link = "Boolean"
      },
      ["@constant"] = {
        fg = "@amber.100"
      },
      ["@constant.builtin"] = {
        fg = "@amber.100",
        bold = true
      },
      ["@variable"] = {
        link = "Variable"
      },
      ["@variable.builtin"] = {
        fg = "@violet.200"
      },
      ["@variable.parameter"] = {
        link = "Parameter"
      },
      ["@variable.member"] = {
        link = "Property"
      },
      ["@property"] = {
        link = "Property"
      },
      ["@lsp.mod.declaration"] = {
        clear = true
      },
      ["@lsp.type.type"] = {
        link = "@type"
      },
      ["@lsp.type.parameter"] = {
        link = "@variable.parameter"
      },
      ["@lsp.type.variable"] = {
        link = "@variable"
      },
      ["@tag.delimiter"] = {
        link = "Punctuation"
      },
      ["@constructor"] = {
        fg = "@foreground.400"
      },
      ["@operator"] = {
        link = "Operator"
      },
      ["@punctuation"] = {
        link = "Punctuation"
      },
      ["@punctuation.bracket"] = {
        link = "Punctuation"
      },
      ["@punctuation.delimiter"] = {
        link = "Punctuation"
      },
      ["@tag"] = {
        link = "Tag"
      },
      ["@tag.builtin"] = {
        fg = "@phantom.100",
        bold = true
      }
    }
  },
  integrations = {
    ghostty = {
      update_config = false
    }
  },
})
vim.g.colors_name = "nocturnal"
