{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./macos.nix
    ../private/tweag.nix
    ../bazel.nix
  ];
}
