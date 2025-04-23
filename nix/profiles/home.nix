{pkgs, ...}: {
  imports = [
    ./common.nix
    ./macos.nix
    ../vlc.nix
    #../elm.nix
    ../private/home.nix
    #../beancount.nix
    ../rust.nix
  ];
}
