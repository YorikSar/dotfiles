{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "Hack";
      theme = "dark:Builtin Solarized Dark,light:Builtin Solarized Light";
    };
  };
  home.packages = [
    pkgs.hack-font
  ];
}
