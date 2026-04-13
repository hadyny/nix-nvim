{
  description = "Neovim derivation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Dedicated input for Neovim to allow independent, stable updates
    nixpkgs-neovim.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";

    csharp-explorer = {
      url = "github:dtrh95/csharp-explorer.nvim";
      flake = false;
    };

    hopcsharp = {
      url = "github:leblocks/hopcsharp.nvim";
      flake = false;
    };

    claudecode = {
      url = "github:coder/claudecode.nvim";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-neovim,
      flake-utils,
      ...
    }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      # This overlay ensures we use Neovim from the dedicated nixpkgs-neovim input
      neovim-version-overlay = final: prev: {
        neovim-unwrapped = nixpkgs-neovim.legacyPackages.${prev.system}.neovim-unwrapped;
      };

      # This is where the Neovim derivation is built.
      neovim-overlay = import ./nix/neovim-overlay.nix { inherit inputs; };
    in
    flake-utils.lib.eachSystem supportedSystems (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            neovim-version-overlay
            # Import the overlay, so that the final Neovim derivation(s) can be accessed via pkgs.<nvim-pkg>
            neovim-overlay
            # This adds a function can be used to generate a .luarc.json
            inputs.gen-luarc.overlays.default
          ];
        };
        shell = pkgs.mkShell {
          name = "nvim-devShell";
          buildInputs = with pkgs; [
            lua-language-server
            nil
            stylua
            luajitPackages.luacheck
            nvim-dev
          ];
          shellHook = ''
            ln -fs ${pkgs.nvim-luarc-json} .luarc.json
            ln -Tfns $PWD/nvim ~/.config/nvim-dev
          '';
        };
      in
      {
        packages = rec {
          default = nvim;
          nvim = pkgs.nvim-pkg;
        };
        devShells = {
          default = shell;
        };
        formatter = pkgs.nixfmt-tree;
      }
    )
    // {
      overlays.default =
        final: prev:
        let
          versionApplied = neovim-version-overlay final prev;
          neovimApplied = neovim-overlay final (prev // versionApplied);
        in
        versionApplied // neovimApplied;
    };
}
