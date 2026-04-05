{
  imports = [
    ../xcrun-subst.nix
    ../alacritty.nix
  ];

  services.dark-mode-notify.enable = true;
  programs.ssh.extraOptionOverrides = {
    UseKeychain = "yes";
  };
}
