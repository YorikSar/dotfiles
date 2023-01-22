{pkgs, ...}: {
  imports = [
    ../xcrun-subst.nix
  ];

  programs.ssh.extraOptionOverrides = {
    UseKeychain = "yes";
  };
}
