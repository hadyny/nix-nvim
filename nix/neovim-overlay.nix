# This overlay, when applied to nixpkgs, adds the final neovim derivation to nixpkgs.
{ inputs }:
final: prev:
with final.pkgs.lib;
let
  pkgs = final;

  # Use this to create a plugin from a flake input
  mkNvimPlugin =
    src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  # Use this to create a plugin that skips the require check
  # Useful for plugins with complex dependencies
  mkNvimPluginNoCheck =
    src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
      doCheck = false;
      nvimRequireCheck = "off";
    };

  # Make sure we use the pinned nixpkgs instance for wrapNeovimUnstable,
  # otherwise it could have an incompatible signature when applying this overlay.
  pkgs-locked = inputs.nixpkgs.legacyPackages.${pkgs.system};

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix {
    inherit (pkgs-locked) wrapNeovimUnstable neovimUtils;
  };

  # A plugin can either be a package or an attrset, such as
  # { plugin = <plugin>; # the package, e.g. pkgs.vimPlugins.nvim-cmp
  #   config = <config>; # String; a config that will be loaded with the plugin
  #   # Boolean; Whether to automatically load the plugin as a 'start' plugin,
  #   # or as an 'opt' plugin, that can be loaded with `:packadd!`
  #   optional = <true|false>; # Default: false
  #   ...
  # }
  all-plugins = with pkgs.vimPlugins; [
    # themes
    catppuccin-nvim
    onenord-nvim
    tokyonight-nvim
    rose-pine
    # lua
    lazydev-nvim
    # nix
    # typescript
    nvim-highlight-colors
    # csharp
    easy-dotnet-nvim
    (mkNvimPlugin inputs.csharp-explorer "csharp-explorer.nvim")
    sqlite-lua
    (mkNvimPluginNoCheck inputs.hopcsharp "hopcsharp.nvim")
    nvim-tree-lua
    nvim-dap
    nvim-dap-ui
    nvim-dap-virtual-text
    # docs
    render-markdown-nvim
    checkmate-nvim
    # completion
    blink-cmp
    lspkind-nvim
    # general
    bufferline-nvim
    quicker-nvim
    mini-nvim
    nvim-treesitter.withAllGrammars
    conform-nvim
    fzf-lua
    yazi-nvim
    # ai
    opencode-nvim

    # bleeding-edge plugins from flake inputs
    # (mkNvimPlugin inputs.wf-nvim "wf.nvim") # (example) keymap hints | https://github.com/Cassin01/wf.nvim
    # ^ bleeding-edge plugins from flake inputs
  ];

  extraPackages = with pkgs; [
    # git
    delta
    # lua
    lua-language-server
    stylua
    # nix
    nixd
    nixfmt
    # typescript
    prettierd
    tailwindcss-language-server
    rustywind
    graphql-language-service-cli
    vscode-langservers-extracted
    vtsls
    # csharp
    roslyn-ls
    netcoredbg
    csharpier
    fsautocomplete
    # docs
    multimarkdown
    marksman
    # ai
    opencode
  ];
in
{
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # This is meant to be used within a devshell.
  # Instead of loading the lua Neovim configuration from
  # the Nix store, it is loaded from $XDG_CONFIG_HOME/nvim-dev
  nvim-dev = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
    appName = "nvim-dev";
    wrapRc = false;
  };

  # This can be symlinked in the devShell's shellHook
  nvim-luarc-json = final.mk-luarc-json {
    plugins = all-plugins;
  };

  # You can add as many derivations as you like.
  # Use `ignoreConfigRegexes` to filter out config
  # files you would not like to include.
  #
  # For example:
  #
  # nvim-pkg-no-telescope = mkNeovim {
  #   plugins = [];
  #   ignoreConfigRegexes = [
  #     "^plugin/telescope.lua"
  #     "^ftplugin/.*.lua"
  #   ];
  #   inherit extraPackages;
  # };
}
