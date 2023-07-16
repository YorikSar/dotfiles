{pkgs, ...}: {
  imports = [
    ../xcrun-subst.nix
    ../alacritty.nix
    ../dark-mode-notify.nix
  ];

  services.dark-mode-notify.enable = true;
  programs.ssh.extraOptionOverrides = {
    UseKeychain = "yes";
  };
}
