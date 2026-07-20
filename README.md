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
| Colorscheme | catppuccin |
| UI | which-key.nvim, bufferline.nvim, fidget.nvim |
| Search | fzf-lua |
| Files | nvim-tree |
| Icons | nvim-web-devicons |
| Completion | blink.cmp (+ blink-compat) |
| Git | gitsigns.nvim, diffview.nvim, neogit |
| Syntax | nvim-treesitter (all grammars) |
| Formatting | conform.nvim |
| Debugging | nvim-dap, nvim-dap-ui, nvim-dap-virtual-text |
| C# / .NET | easy-dotnet.nvim, csharp-explorer.nvim, hopcsharp.nvim |
| Markdown | render-markdown.nvim, checkmate.nvim |
| Org | orgmode, org-bullets.nvim, org-modern.nvim |
| AI | opencode.nvim, claudecode.nvim |
| Colours | nvim-highlight-colors |

## Language support

Managed by Nix — no manual installation needed.

| Language | LSP | Formatter | Other |
|---|---|---|---|
| TypeScript / JS | vtsls, ESLint, Tailwind CSS | prettierd, rustywind | graphql-language-service |
| Astro | astro-language-server | — | ESLint, Tailwind CSS |
| C# / F# | roslyn-ls, fsautocomplete | csharpier | netcoredbg (DAP), EasyDotnet |
| Go | gopls | gofmt, goimports | staticcheck |
| Lua | lua-language-server | stylua | — |
| Nix | nixd | nixfmt | — |
| Markdown | marksman | prettierd | multimarkdown |
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
| `<leader>/` | Live grep |
| `<leader>s` | Grep (prompt) |
| `<leader>e` | Explorer (nvim-tree) |
| `<leader>u` | Toggle undotree |
| `<C-h/j/k/l>` | Window navigation |

### Buffers

| Keys | Action |
|---|---|
| `[b` / `]b` | Previous / next buffer |
| `<S-h>` / `<S-l>` | Cycle previous / next (bufferline) |
| `<A-S-h>` / `<A-S-l>` | Move buffer left / right |
| `<leader>1`–`<leader>8` | Go to buffer by position |
| `<leader>bp` | Pick buffer |
| `<leader>bx` | Close other buffers |
| `<leader>x` | Close buffer |

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
| `<leader>gg` | Neogit status |
| `<leader>gc` | Neogit commit |
| `<leader>gp` / `<leader>gP` | Neogit pull / push |
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
| `<leader>htd` | Toggle deleted |

### C# / .NET (buffer-local to C# files)

| Keys | Action |
|---|---|
| `<F5>` | Debug: start / continue |
| `<F10>` / `<F11>` / `<F12>` | Step over / into / out |
| `<F7>` | Toggle debug UI |
| `<leader>dB` | Toggle breakpoint |
| `<leader>dq` | Terminate & clear breakpoints |
| `<leader>dr` / `<leader>db` / `<leader>dt` | Dotnet run / build / test |
| `<leader>dn` | Dotnet command menu |
| `<leader>cse` | C# explorer |
| `<leader>csd` | Hop to definition |

### Org

| Keys | Action |
|---|---|
| `<leader>oa` | Agenda |
| `<leader>oc` | Capture |

### AI

| Keys | Action |
|---|---|
| `<C-a>` | OpenCode: ask with context |
| `<C-.>` | OpenCode: toggle |
| `<C-x>` | OpenCode: action menu |
| `<leader>cc` | Claude Code: toggle |
| `<leader>cf` | Claude Code: focus |
| `<leader>cS` | Claude Code: send selection (visual) |
| `<leader>cm` | Claude Code: select model |

### Toggles & misc

| Keys | Action |
|---|---|
| `<leader>ts` | Toggle spellcheck |
| `<leader>tf` | Toggle treesitter folding |
| `<leader>w` | Save file |
| `<leader>fq` | Close floating windows |
| `<A-j>` / `<A-k>` | Move line down / up |
| `<leader>y` / `<leader>Y` | Yank selection / line to clipboard |
| `<leader>p` | Paste from clipboard |

## Directory structure

```
├── flake.nix                  # Inputs, outputs, devenv shell
├── nix/
│   ├── neovim-overlay.nix     # Plugin list, extra packages, derivations
│   └── mkNeovim.nix           # Neovim derivation builder
└── nvim/
    ├── init.lua               # Options, diagnostics, colorscheme, statusline
    ├── plugin/                # Auto-sourced at startup
    │   ├── keymaps.lua
    │   ├── autocommands.lua
    │   ├── commands.lua        # Custom :LspInfo, :Q
    │   ├── plugins.lua         # conform, render-markdown, checkmate
    │   ├── fzf-lua.lua         # Finder, grep, recent files
    │   ├── nvim-tree.lua       # File explorer
    │   ├── bufferline.lua      # Buffer tabline
    │   ├── blink-cmp.lua       # Completion
    │   ├── gitsigns.lua
    │   ├── diffview.lua        # Diff viewer
    │   ├── neogit.lua          # Git UI
    │   ├── treesitter.lua
    │   ├── which-key.lua
    │   ├── highlight-colors.lua
    │   ├── orgmode.lua         # Org mode, agenda, capture
    │   ├── opencode.lua        # AI: OpenCode
    │   └── claudecode.lua      # AI: Claude Code
    ├── ftplugin/              # Filetype-specific (LSP startup)
    │   ├── typescript.lua
    │   ├── typescriptreact.lua
    │   ├── astro.lua
    │   ├── cs.lua              # LSP, DAP, EasyDotnet, C# tools
    │   ├── go.lua
    │   ├── lua.lua
    │   ├── markdown.lua
    │   └── nix.lua
    └── lua/user/
        ├── lsp.lua            # Shared LSP capabilities (blink.cmp)
        ├── web_servers.lua    # Shared ESLint / Tailwind starters
        ├── statusline.lua     # Custom statusline
        └── icons.lua          # Shared icon set
```
