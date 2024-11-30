{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        cabal2nix = pkgs.haskellPackages.callCabal2nix;
      in 
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.ghc
            pkgs.cabal-install
          ];
        };

        packages.default = cabal2nix "aoc24" ./. {};
      }
    );
}
