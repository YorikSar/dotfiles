let
  sources = import ./nix/sources.nix;
in
{ 
  pkgs ? import sources.nixpkgs {}
}:
let
  home-manager = import sources.home-manager { inherit pkgs; };
in
pkgs.mkShell {
  buildInputs = [
    pkgs.niv
    home-manager.home-manager
  ];
}
