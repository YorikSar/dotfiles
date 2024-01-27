{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "${config.xdg.configHome}/alacritty/current_theme.toml"
      ];
      window.startup_mode = "Fullscreen";
      font.normal.family = "Hack";
    };
  };
  home.packages = [
    pkgs.hack-font
  ];
  xdg.configFile."alacritty/theme".source = pkgs.alacritty-theme;
  home.activation.alacritty-theme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -e  "${config.xdg.configHome}/alacritty/current_theme.toml" ]; then
      $DRY_RUN_CMD ln -s $VERBOSE_ARG "theme/solarized_dark.toml" "${config.xdg.configHome}/alacritty/current_theme.toml"
    fi
  '';
  services.dark-mode-notify.onSwitch = [
    ''
      if [ "$DARKMODE" -eq 0 ]; then
        theme=light
      else
        theme=dark
      fi
      ln -fs "theme/solarized_''${theme}.toml" "${config.xdg.configHome}/alacritty/current_theme.toml"
    ''
  ];
}
