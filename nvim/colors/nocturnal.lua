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
    periwinkle = "#7d94c2",
    phantom = "#A0DAA9",
    violet = "#9483bf"
  },
  highlights = {
    syntax = {
      ["@property"] = {
        link = "Property"
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
        bold = true,
        fg = "@phantom.100"
      },
      ["@tag.attribute"] = {
        fg = "@phantom.400"
      },
      ["@tag.delimiter"] = {
        link = "Punctuation"
      },
      ["@attribute"] = {
        link = "Attribute"
      },
      ["@attribute.builtin"] = {
        bold = true,
        fg = "@phantom.100"
      },
      ["@lsp.type.variable"] = {
        link = "@variable"
      },
      ["@lsp.type.property"] = {
        link = "@property"
      },
      Comment = {
        italic = true,
        fg = "@foreground.400"
      },
      ["@lsp.type.function"] = {
        link = "@function"
      },
      ["@lsp.type.type"] = {
        link = "@type"
      },
      Keyword = {
        fg = "@violet.300"
      },
      ["@lsp.mod.declaration"] = {
        clear = true
      },
      Conditional = {
        fg = "@violet.200"
      },
      Function = {
        fg = "@accent.300"
      },
      Type = {
        fg = "@accent.200"
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
      ["@lsp.typemod.property.declaration"] = {
        link = "@property"
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
      ["@lsp.type.decorator"] = {
        link = "@attribute"
      },
      ["@function"] = {
        link = "Function"
      },
      ["@function.builtin"] = {
        bold = true,
        fg = "@accent.100"
      },
      ["@lsp.type.parameter"] = {
        link = "@variable.parameter"
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
        bold = true,
        fg = "@amber.100"
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
      }
    },
    editor = {
      CursorLineNr = {
        bold = true,
        fg = "@amber.100"
      },
      MatchParen = {
        bold = true,
        fg = "@amber.100"
      }
    }
  },
  integrations = {
    ghostty = {
      enabled = false
    }
  },
})
vim.g.colors_name = "nocturnal"
