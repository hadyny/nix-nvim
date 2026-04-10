# nix-nvim

Personal Neovim configuration managed with Nix flakes. Plugins and external tools (LSPs, formatters, debuggers) are pinned and installed via Nix. All Neovim configuration is in Lua.

Built on the [kickstart-nix.nvim](https://github.com/nix-community/kickstart-nix.nvim) template.

## Usage

Run without installing:

```console
nix run .#nvim
```

Install to profile:

```console
nix profile install .#nvim
```

Enter dev shell for fast iteration (config loaded from `$XDG_CONFIG_HOME/nvim-dev`):

```console
nix develop
nvim-dev
```

> [!NOTE]
> New files must be staged with `git add` before Nix will pick them up.

## Plugins

| Category | Plugins |
|---|---|
| Colorscheme | rose-pine |
| UI | which-key.nvim |
| Search | fzf-lua |
| Files | nvim-tree |
| Editing | quicker.nvim |
| Icons | nvim-web-devicons |
| Completion | blink.cmp |
| Git | gitsigns.nvim, diffview.nvim |
| Syntax | nvim-treesitter (all grammars) |
| Formatting | conform.nvim |
| Debugging | nvim-dap, nvim-dap-ui, nvim-dap-virtual-text |
| C# / .NET | easy-dotnet.nvim, csharp-explorer.nvim, hopcsharp.nvim |
| Lua | lazydev.nvim |
| Markdown | render-markdown.nvim, checkmate.nvim |
| AI | opencode.nvim, claudecode.nvim |
| Colours | nvim-highlight-colors |

## Language support

Managed by Nix — no manual installation needed.

| Language | LSP | Formatter | Other |
|---|---|---|---|
| TypeScript / JS | vtsls, ESLint, Tailwind CSS | prettierd, rustywind | graphql-language-service |
| C# / F# | roslyn-ls, fsautocomplete | csharpier | netcoredbg (DAP) |
| Lua | lua-language-server | stylua | — |
| Nix | nixd | nixfmt | nil (optional) |
| Markdown | marksman | multimarkdown | — |
| HTML / CSS / JSON | vscode-langservers-extracted | prettierd | — |

## Key bindings

Leader key: `<space>`

### Navigation & search

| Keys | Action |
|---|---|
| `<leader><leader>` | Commands |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fb` | Find buffers |
| `<leader>/` | Grep |
| `<C-f>` | Search in buffer |
| `<leader>e` | Explorer (nvim-tree) |
| `[b` / `]b` | Previous / next buffer |
| `<C-h/j/k/l>` | Window navigation |

### Diagnostics

| Keys | Action |
|---|---|
| `[d` / `]d` | Previous / next diagnostic |
| `[e` / `]e` | Previous / next error |
| `<leader>dk` | Diagnostics float |
| `<leader>ds` | Diagnostics to quickfix |
| `<leader>tD` | Toggle buffer diagnostics |

### Git

| Keys | Action |
|---|---|
| `<leader>gC` | Commit with koji |
| `<leader>gb` | Git blame line |
| `<leader>gd` | Diffview open |
| `<leader>gh` | Diffview file history |
| `<leader>gH` | Diffview branch history |

### Hunks (gitsigns)

| Keys | Action |
|---|---|
| `[h` / `]h` | Previous / next hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hr` | Reset hunk |
| `<leader>hR` | Reset buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hd` | Diff this |

### Debugging (DAP)

| Keys | Action |
|---|---|
| `<F5>` | Continue |
| `<F10>` / `<F11>` / `<F12>` | Step over / into / out |
| `<F7>` | Toggle debug UI |
| `<leader>B` | Toggle breakpoint |

### AI

| Keys | Action |
|---|---|
| `<C-a>` | OpenCode: ask with context |
| `<C-.>` | OpenCode: toggle |
| `<C-x>` | OpenCode: action menu |
| `<leader>cc` | Claude Code: toggle |
| `<leader>cf` | Claude Code: focus |
| `<leader>cs` | Claude Code: send selection |
| `<leader>cm` | Claude Code: select model |
### Toggles & misc

| Keys | Action |
|---|---|
| `<leader>ts` | Toggle spellcheck |
| `<leader>tf` | Toggle treesitter folding |
| `<leader>w` | Save file |
| `<leader>x` | Close buffer |
| `<A-j>` / `<A-k>` | Move line up / down |
| `<leader>y` / `<leader>p` | Yank / paste clipboard |

## Directory structure

```
├── flake.nix                  # Inputs, outputs, shell
├── nix/
│   ├── neovim-overlay.nix     # Plugin list, extra packages, derivations
│   └── mkNeovim.nix           # Neovim derivation builder
└── nvim/
    ├── init.lua               # Options, diagnostics, colorscheme
    ├── plugin/                # Auto-sourced at startup
    │   ├── keymaps.lua
    │   ├── autocommands.lua
    │   ├── commands.lua
    │   ├── plugins.lua        # conform, render-markdown, checkmate
    │   ├── fzf-lua.lua         # Finder, grep, recent files
    │   ├── nvim-tree.lua      # File explorer
    │   ├── blink-cmp.lua      # Completion
    │   ├── gitsigns.lua
    │   ├── diffview.lua       # Diff viewer
    │   ├── treesitter.lua
    │   ├── which-key.lua
    │   ├── lazydev.lua         # Lua dev setup
    │   ├── quicker.lua        # Quickfix enhancements
    │   ├── highlight-colors.lua
    │   ├── opencode.lua       # AI: OpenCode
    │   └── claudecode.lua     # AI: Claude Code
    ├── ftplugin/              # Filetype-specific (LSP startup)
    │   ├── typescript.lua
    │   ├── typescriptreact.lua
    │   ├── cs.lua
    │   ├── lua.lua
    │   ├── markdown.lua
    │   └── nix.lua
    └── lua/user/
        └── lsp.lua            # Shared LSP capabilities (blink.cmp)
```
