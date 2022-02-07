{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bazel_4
  ];
  home.file.".bazelrc".text = ''
    build --disk_cache=~/.cache/bazel
  '';
}
