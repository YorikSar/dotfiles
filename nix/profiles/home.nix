{pkgs, ...}: {
  imports = [
    ./common.nix
    ./macos.nix
    ../mpv.nix
    ../elm.nix
    ../private/home.nix
    ../beancount.nix
    ../rust.nix
  ];
}
