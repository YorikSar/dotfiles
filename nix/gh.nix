{pkgs, ...}: {
  programs.gh = {
    enable = true;
    package = pkgs.callPackage ./pkgs/gh.nix {};
    settings = {
      aliases.co = "pr checkout";
    };
  };
  xdg.configFile."gh/hosts.yml".source = (pkgs.formats.yaml {}).generate "gh-hosts.yml" {
    "github.com".user = "YorikSar";
  };
}
