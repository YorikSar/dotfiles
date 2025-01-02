{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../xcrun-subst.nix
    ../ghostty.nix
  ];

  services.dark-mode-notify.enable = true;
  programs.ssh.extraOptionOverrides = {
    UseKeychain = "yes";
  };
}
