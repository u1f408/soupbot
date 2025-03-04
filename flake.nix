{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, ... } @ inputs:
    with flake-utils.lib;
    eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ ];
        };

        ruby = pkgs.ruby_3_3;
        bundler = pkgs.bundler.override (_: { inherit ruby; });
      in rec {
        devShells.default = pkgs.mkShell {
          buildInputs = [ ruby bundler ];
          packages = with pkgs; [
            imagemagick
            exiftool
            jpegoptim
          ];
        };
      });
}
