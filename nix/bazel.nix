{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bazel_4
  ];
  home.file.".bazelrc".text = ''
    build --disk_cache=~/.cache/bazel
    build --repo_env=BAZEL_CXXOPTS="-I${pkgs.libcxx.dev}/include/c++/v1"
  '';
}
