{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ../mpv.nix
    ../elm.nix
    ../private/home.nix
    ../beancount.nix
  ];
}

