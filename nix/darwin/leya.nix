{pkgs, ...}: {
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
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      extra-platforms = [
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      sandbox = true;
      min-free = 10 * 1024 * 1024 * 1024;
      max-free = 50 * 1024 * 1024 * 1024;
    };
    package = pkgs.nixUnstable;
  };
  environment.etc."pam.d/sudo_local".text = ''
    auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so
    auth       sufficient     pam_tid.so
  '';
}
