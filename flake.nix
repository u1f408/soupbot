{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
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

        ruby = pkgs.ruby_3_1;
	bundler = pkgs.bundler.override (_: { inherit ruby; });
      in rec {
        devShells.default = pkgs.mkShell {
          buildInputs = [ ruby bundler ];
          packages = with pkgs; [ ];
        };
      });
}
