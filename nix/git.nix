{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    ignores = [
      "*.swp"
      "*.pyc"
      "*.egg-info"
      "build"
      ".coverage"
      "htmlcov"
      ".DS_Store"
    ];
    signing.format = "ssh";
    settings = {
      user.name = "Yuriy Taraday";
      user.email = "yuriy@taraday.nl";
      alias = {
        co = "checkout";
        pick = "cherry-pick";
        "log-all" = "log --all --graph --pretty=tformat:'%C(auto)%h%d %s [%an,%cr]'";
      };
      # Use system OpenSSH that includes patches for Keychain support
      core.sshCommand = lib.mkIf pkgs.stdenv.isDarwin "/usr/bin/ssh";
      # Wrap ssh-keygen that doesn't integrate with Keychain by using ssh-add that does
      gpg.ssh.program = lib.mkIf pkgs.stdenv.isDarwin (
        lib.getExe (
          pkgs.writeShellApplication {
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
          }
        )
      );
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
  nixpkgs.overlays = [
    # Make sure we can build edencommon, dependency of watchman, tests don't work on macOS with auto-allocate-uid
    (final: prev: { edencommon = prev.edencommon.overrideAttrs { doCheck = false; }; })
    # Port of https://github.com/NixOS/nixpkgs/pull/523139 for folly, one of watchman deps
    (final: prev: {
      folly = prev.folly.overrideAttrs (old: {
        patches = old.patches ++ [
          (final.fetchpatch2 {
            url = "https://github.com/facebook/folly/commit/fdde9bc360d525a1b2889b9ba89d671c3a13e72e.patch?full_index=1";
            hash = "sha256-+1XJRAl4o9YubjqdIgQZpyrMmcb2imBfQUmiHNmFMRE=";
          })
        ];
      });
    })
  ];
}
