{pkgs, ...}: {
  programs.gh = {
    enable = true;
    package = pkgs.callPackage ./pkgs/gh.nix {};
    settings = {
      aliases.co = "pr checkout";
    };
  };
}
