{
  description = "Neovim derivation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";

    neovim-src = {
      url = "github:neovim/neovim/v0.12.0";
      flake = false;
    };

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

    ninetynine = {
      url = "github:ThePrimeagen/99";
      flake = false;
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    let
      systems = builtins.attrNames nixpkgs.legacyPackages;

      neovim-src-overlay = final: prev: {
        neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs {
          src = inputs.neovim-src;
          version = "0.12.0";
        };
      };

      # This is where the Neovim derivation is built.
      neovim-overlay = import ./nix/neovim-overlay.nix { inherit inputs; };
    in
    flake-utils.lib.eachSystem systems (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            neovim-src-overlay
            # Import the overlay, so that the final Neovim derivation(s) can be accessed via pkgs.<nvim-pkg>
            neovim-overlay
            # This adds a function can be used to generate a .luarc.json
            # containing the Neovim API all plugins in the workspace directory.
            # The generated file can be symlinked in the devShell's shellHook.
            inputs.gen-luarc.overlays.default
          ];
        };
        shell = pkgs.mkShell {
          name = "nvim-devShell";
          buildInputs = with pkgs; [
            # Tools for Lua and Nix development, useful for editing files in this repo
            lua-language-server
            nil
            stylua
            luajitPackages.luacheck
            nvim-dev
          ];
          shellHook = ''
            # symlink the .luarc.json generated in the overlay
            ln -fs ${pkgs.nvim-luarc-json} .luarc.json
            # allow quick iteration of lua configs
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
      }
    )
    // {
      # You can add this overlay to your NixOS configuration
      overlays.default = final: prev:
        let
          srcApplied = neovim-src-overlay final prev;
          neovimApplied = neovim-overlay final (prev // srcApplied);
        in
        srcApplied // neovimApplied;
    };
}
