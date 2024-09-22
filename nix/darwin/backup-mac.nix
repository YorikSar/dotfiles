{pkgs, ...}: {
  imports = [
    ../private/darwin/backup-mac.nix
  ];
  system.stateVersion = 5;
  ids.gids.nixbld = 30000;
  programs.zsh = {
    enable = true;
    promptInit = "setopt transientrprompt";
  };
  services.nix-daemon.enable = true;
  nix = {
    configureBuildUsers = true;
    optimise.automatic = true;
    settings = {
      sandbox = true;
      min-free = 10 * 1024 * 1024 * 1024;
      max-free = 50 * 1024 * 1024 * 1024;
      trusted-users = ["admin"];
    };
    package = pkgs.nixVersions.latest;
  };

  users.users.admin = {
    home = "/Users/admin";
    shell = pkgs.zsh;
  };
  home-manager = {
    sharedModules = [
      ../xcrun-subst.nix
      ../zsh.nix
      {home.stateVersion = "24.05";}
    ];
    users.admin = {};
  };
}
