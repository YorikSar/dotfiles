{pkgs, ...}: {
  imports = [
    ../xcrun-subst.nix
    ../alacritty.nix
  ];

  programs.ssh.extraOptionOverrides = {
    UseKeychain = "yes";
  };
}
