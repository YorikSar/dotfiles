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
    userKnownHostsFile = "~/.ssh/known_hosts ~/.ssh/hm_known_hosts";
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github.com";
      };
    };
  };
  home.file.".ssh/hm_known_hosts".text = ''
    github.com,140.82.118.4 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
  '';
  home.packages = with pkgs; [
    mosh
  ];
}
