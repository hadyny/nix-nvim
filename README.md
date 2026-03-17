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
| Colorscheme | rose-pine, catppuccin, tokyonight, onenord |
| UI | snacks.nvim (explorer, picker, indent, git), bufferline.nvim, lualine.nvim, which-key.nvim, nvim-scrollbar, nvim-hlslens |
| Editing | mini.nvim (pairs, cursorword, icons), quicker.nvim |
| Completion | blink.cmp |
| Files | nvim-tree, fzf-lua |
| Git | gitsigns.nvim, neogit |
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
| Nix | nil | nixfmt | nixd |
| Markdown | marksman | multimarkdown | — |
| HTML / CSS / JSON | vscode-langservers-extracted | prettierd | — |

## Key bindings

Leader key: `<space>`

### Navigation & search

| Keys | Action |
|---|---|
| `<leader><leader>` | Smart find files |
| `<leader>,` | Find buffers |
| `<leader>/` | Grep |
| `<leader>:` | Command history |
| `<C-f>` | Search in buffer |
| `<leader>e` | Explorer |
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
| `<leader>gb` | Git blame line |
| `<leader>go` | Git browse online |
| `<leader>gc` | Commit with koji |

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
| `<leader>cc` | Claude Code: toggle |
| `<leader>cs` | Claude Code: send selection |

### Toggles & misc

| Keys | Action |
|---|---|
| `<leader>ts` | Toggle spellcheck |
| `<leader>tf` | Toggle treesitter folding |
| `<leader>w` | Save file |
| `<leader>x` | Close buffer |
| `<A-j>` / `<A-k>` | Move line up / down |

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
    │   ├── plugins.lua        # conform, treesitter, render-markdown, checkmate
    │   ├── autocommands.lua
    │   ├── commands.lua
    │   ├── snacks.lua         # Explorer, picker, git, indent
    │   ├── mini.lua           # Pairs, cursorword, icons
    │   ├── blink-cmp.lua      # Completion
    │   ├── bufferline.lua
    │   ├── lualine.lua        # Statusline
    │   ├── fzf-lua.lua
    │   ├── gitsigns.lua
    │   ├── neogit.lua
    │   ├── which-key.lua
    │   ├── dotnet.lua         # DAP + C# tooling
    │   ├── opencode.lua       # AI: OpenCode
    │   └── claudecode.lua     # AI: Claude Code
    ├── ftplugin/              # Filetype-specific (LSP startup)
    │   ├── typescript.lua
    │   ├── lua.lua
    │   ├── markdown.lua
    │   └── nix.lua
    └── lua/user/
        └── lsp.lua            # Shared LSP capabilities (blink.cmp)
```
