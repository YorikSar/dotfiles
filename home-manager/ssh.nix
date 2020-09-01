{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPath = "~/.ssh/%C.ctl";
    controlPersist = "yes";
    serverAliveInterval = 5;
    extraOptionOverrides = {
      UseKeychain = "yes";
    };
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github.com";
      };
    };
  };
}
