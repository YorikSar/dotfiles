{ config, pkgs, ... }:
let
  requirements = import ./requirements.nix {inherit pkgs;};
  openstackclient = pkgs.python3Packages.toPythonApplication requirements.packages."python-openstackclient";
in
  {
    home.packages = [
      openstackclient
    ];
  }
