{
  inputs = {
    haskell-nix.url = "github:input-output-hk/haskell.nix";
    nixpkgs.follows = "haskell-nix/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk/master";
    nixpkgs-mozilla = {
      url = "github:mozilla/nixpkgs-mozilla";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, haskell-nix, naersk, nixpkgs-mozilla }:
    utils.lib.eachDefaultSystem (system:
      let
        toolchain = (pkgs.rustChannelOf {
          rustToolchain = ./sha3/rust-toolchain;
          sha256 = "sha256-lhGNvHjWaXp34/80o44GkO2AfukCxN3+T3rNPPdEcw8=";
        }).rust;
        naersk' = pkgs.callPackage naersk {
          cargo = toolchain;
          rustc = toolchain;
        };
        overlays = [
          haskell-nix.overlay
          (final: prev: {
            # Add `extra-libraries` dependencies
            sha3 = naersk'.buildPackage {
              src = ./sha3;
              copyLibs = true;
            };
            # This overlay adds our project to pkgs
            project = final.haskell-nix.project' {
              src = ./.;
              compiler-nix-name = "ghc924";
              # This is used by `nix develop .` to open a shell for use with
              # `cabal`, `hlint` and `haskell-language-server`
              shell.tools = {
                cabal = "latest";
                hlint = "latest";
                haskell-language-server = "latest";
              };
              # Non-Haskell shell tools go here
              shell.buildInputs = [ toolchain ];
            };
          }) (import nixpkgs-mozilla)
        ];
        pkgs = import nixpkgs {
          inherit system overlays;
          inherit (haskell-nix) config;
        };
        flake = pkgs.project.flake { };
      in flake // {
        # Built by `nix build .`
        packages.default = flake.packages."sha3:lib:sha3";
      });
}
