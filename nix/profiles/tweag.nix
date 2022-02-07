{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ../private/tweag.nix
    ../bazel.nix
  ];
}
