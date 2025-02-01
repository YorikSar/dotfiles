{pkgs, lib, ...}: {
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
      # Use system OpenSSH that includes patches for Keychain support
      core.sshCommand = lib.mkIf pkgs.stdenv.isDarwin "/usr/bin/ssh";
      # Wrap ssh-keygen that doesn't integrate with Keychain by using ssh-add that does
      gpg.ssh.program = lib.mkIf pkgs.stdenv.isDarwin (lib.getExe (pkgs.writeShellApplication {
        name = "ssh-keygen-sign";
        text = ''
          args=("$@")
          key=
          for i in $(seq "$((''${#args[@]} - 1))"); do
            if [ "''${args[$i]}" = "-f" ]; then
              key="''${args[$((i+1))]%%.pub}"
              break
            fi
          done
          if [ -z "$key" ]; then
            ssh-keygen "$@"
            exit
          fi
          eval "$(ssh-agent)"
          cleanup() {
            eval "$(ssh-agent -k)"
          }
          trap cleanup EXIT
          ssh-add --apple-use-keychain "$key"
          ssh-keygen "$@"
        '';
      }));
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
      core.fsmonitor = "true";
      core.untrackedCache = "true";
      tag.sort = "-version:refname";
      url."https://github.com/".insteadOf = "git@github.com:";
    };
  };
  home.packages = with pkgs; [
    watchman
    git-crypt
  ];
}
