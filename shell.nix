{ 
  pkgs ? import ./nix/pkgs
}:
with pkgs;
mkShell {
  buildInputs = [
    niv
    home-manager
  ];
}
