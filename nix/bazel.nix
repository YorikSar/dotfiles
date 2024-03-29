{pkgs, ...}: {
  home.packages = with pkgs; [
    bazel
  ];
  home.file.".bazelrc".text = ''
    build --repo_env=BAZEL_CXXOPTS="-I${pkgs.libcxx.dev}/include/c++/v1"
  '';
}
