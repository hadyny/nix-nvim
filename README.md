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
| UI | snacks.nvim, mini.nvim (statusline, completion, cmdline, icons, pairs) |
| Files | nvim-tree, yazi.nvim |
| Git | gitsigns.nvim |
| Syntax | nvim-treesitter (all grammars) |
| Formatting | conform.nvim |
| Debugging | nvim-dap, nvim-dap-ui, nvim-dap-virtual-text |
| C# / .NET | easy-dotnet.nvim, csharp-explorer.nvim |
| Markdown | render-markdown.nvim, checkmate.nvim |
| AI | opencode.nvim |
| Colours | nvim-highlight-colors |

## Language support

Managed by Nix — no manual installation needed.

| Language | LSP | Formatter | Other |
|---|---|---|---|
| TypeScript / JS | vtsls, ESLint, Tailwind CSS | prettierd, rustywind | graphql-language-service |
| C# / F# | roslyn-ls, fsautocomplete | csharpier | netcoredbg (DAP) |
| Lua | lua-language-server | stylua | luacheck |
| Nix | nixd | nixfmt | — |
| Markdown | marksman | multimarkdown | — |
| HTML / CSS / JSON | vscode-langservers-extracted | prettierd | — |

## Key bindings

Leader key: `<space>`

| Keys | Action |
|---|---|
| `<leader><leader>` | Find files |
| `<leader>b` | Buffers |
| `<leader>/` | Live grep |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>dt` | Toggle inline diagnostics |
| `<F5>` | DAP: continue |
| `<F10>` / `<F11>` / `<F12>` | DAP: step over / into / out |
| `<F7>` | Toggle debug UI |
| `<leader>B` | Toggle breakpoint |
| `<C-a>` | AI: ask with context |
| `<C-.>` | AI: toggle panel |
| `<leader>S` | Toggle spellcheck |

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
    │   ├── plugins.lua        # Plugin setup calls
    │   ├── autocommands.lua
    │   ├── commands.lua
    │   ├── snacks.lua
    │   ├── mini.lua
    │   ├── dotnet.lua         # DAP + C# tooling
    │   └── opencode.lua       # AI assistant
    ├── ftplugin/              # Filetype-specific (LSP startup)
    │   ├── typescript.lua
    │   ├── typescriptreact.lua
    │   ├── lua.lua
    │   ├── markdown.lua
    │   └── nix.lua
    └── lua/user/
        └── lsp.lua            # Shared LSP capabilities
```
