{ config, pkgs, ... }:
let
  nix-upgrade = pkgs.substituteAll {
    name = "nix-upgrade";
    src = ./nix-upgrade.sh;
    dir = "bin";
    isExecutable = true;

    inherit (pkgs) runtimeShell;
  };
in { 
  home.packages = [
    nix-upgrade
  ];
}
