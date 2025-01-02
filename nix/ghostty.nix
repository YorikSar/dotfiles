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
      window-padding-x = 0;
      window-padding-y = 0;
      window-padding-balance = true;
      window-padding-color = "extend";
    };
  };
  home.packages = [
    pkgs.hack-font
  ];
}
