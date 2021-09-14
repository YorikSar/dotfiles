{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Yuriy Taraday";
    userEmail = "yorik.sar@gmail.com";
    aliases = {
      co = "checkout";
      pick = "cherry-pick";
      "log-all" = "log --all --graph --pretty=tformat:'%C(auto)%h%d %s [%an,%cr]'";
    };
    ignores = [
      "*.swp"
      "*.pyc"
      "*.egg-info"
      "build"
      ".coverage"
      "htmlcov"
    ];
    extraConfig = {
      core.sshCommand = "/usr/bin/ssh";  # OpenSSH in nix doesn't support UseKeychain
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
      };
      log.decorate = "true";
      push.default = "simple";
      pull.rebase = "true";
      gitreview.rebase = "false";
      status = {
        short = "true";
        branch = "true";
      };
      http.cookiefile = "/home/yorik/.gitcookies";
      core.fsmonitor = "${config.programs.git.package}/share/git-core/templates/hooks/fsmonitor-watchman.sample";
      core.untrackedCache = "true";
      tag.sort = "-version:refname";
    };
  };
  home.packages = with pkgs; [
    watchman
    git-crypt
  ];
}
