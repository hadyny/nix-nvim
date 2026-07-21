{
  description = "Neovim derivation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Dedicated input for Neovim to allow independent, stable updates
    nixpkgs-neovim.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";

    devenv.url = "github:cachix/devenv";
    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";

    csharp-explorer = {
      url = "github:dtrh95/csharp-explorer.nvim";
      flake = false;
    };

    hopcsharp = {
      url = "github:leblocks/hopcsharp.nvim";
      flake = false;
    };

    org-bullets = {
      url = "github:nvim-orgmode/org-bullets.nvim";
      flake = false;
    };

    org-modern = {
      url = "github:danilshvalov/org-modern.nvim";
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
        inherit (nixpkgs-neovim.legacyPackages.${prev.stdenv.hostPlatform.system}) neovim-unwrapped;
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
        shell = inputs.devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [
            {
              packages = with pkgs; [
                lua-language-server
                stylua
                luajitPackages.luacheck
                nvim-dev
              ];

              enterShell = ''
                ln -fs ${pkgs.nvim-luarc-json} .luarc.json
                ln -Tfns $PWD/nvim ~/.config/nvim-dev
                # Hand git hooks over to devenv (drop the old .githooks path)
                git config --local --unset-all core.hooksPath 2>/dev/null || true
              '';

              git-hooks.hooks = {
                # Was: luacheck nvim/lua
                luacheck.enable = true;
                # Was: nix fmt -- --ci
                nixfmt-rfc-style.enable = true;
                # Was: .githooks/pre-push -> nix flake check
                flake-check = {
                  enable = true;
                  name = "nix flake check";
                  entry = "nix flake check --impure";
                  pass_filenames = false;
                  stages = [ "pre-push" ];
                };
              };
            }
          ];
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
