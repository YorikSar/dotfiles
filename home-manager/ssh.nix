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
      "gerrit.mcp.mirantis.com" = {
        user = "ytaraday";
        port = 29418;
        identityFile = "~/.ssh/gerrit.mcp.mirantis.com";
      };
      "yt-dev-18" = {
        user = "ubuntu";
        hostname = "172.19.115.99";
        identityFile = "~/.ssh/yt-dev-18";
      };
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github.com";
      };
    };
  };
}
