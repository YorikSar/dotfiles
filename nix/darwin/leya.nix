{pkgs, lib, ...}: {
  imports = [
    ../private/darwin/home.nix
    ../private/darwin/tweag.nix
  ];
  programs.zsh = {
    enable = true;
    promptInit = "setopt transientrprompt";
  };
  services.nix-daemon.enable = true;
  nix = {
    configureBuildUsers = true;
    distributedBuilds = true;
    linux-builder = {
      enable = true;
      config = {
        virtualisation.darwin-builder = {
          memorySize = 8 * 1024;
          diskSize = 40 * 1024;
          min-free = 4 * 1024 * 1024 * 1024;
          max-free = 8 * 1024 * 1024 * 1024;
        };
        virtualisation.cores = 4;
      };
      maxJobs = 4;
    };
    optimise.automatic = true;
    settings.extra-trusted-users = ["no-such-user"];
    settings = {
      builders-use-substitutes = true;
      extra-platforms = [
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      sandbox = true;
      min-free = 10 * 1024 * 1024 * 1024;
      max-free = 50 * 1024 * 1024 * 1024;
    };
    package = pkgs.nixVersions.latest;
  };
  environment.etc."pam.d/sudo_local".text = ''
    auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so
    auth       sufficient     pam_tid.so
  '';
}
