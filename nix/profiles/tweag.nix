{ config, pkgs, lib, ... }:

{
  imports = [
    ./common.nix
    ./macos.nix
    ../private/tweag.nix
    ../bazel.nix
  ];

  programs.git.userEmail = lib.mkOverride 10 "yuriy.taraday@tweag.io";
}
