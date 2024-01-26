{
  lib,
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "~/.local/state/alacritty/theme.toml"
      ];
      window.startup_mode = "Fullscreen";
      font.normal.family = "Hack";
    };
  };
  home.packages = [
    pkgs.hack-font
  ];
  home.activation.alacritty-theme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "$HOME/.local/state/alacritty"
    if [ ! -e  "$HOME/.local/state/alacritty/theme.toml" ]; then
      $DRY_RUN_CMD ln -s $VERBOSE_ARG "${pkgs.alacritty-theme}/solarized_dark.toml" "$HOME/.local/state/alacritty/theme.toml"
    fi
  '';
  services.dark-mode-notify.onSwitch = [
    ''
      if [ "$DARKMODE" -eq 0 ]; then
        theme=light
      else
        theme=dark
      fi
      themefile="${pkgs.alacritty-theme}/solarized_''${theme}.toml"
      ln -fs "$themefile" "$HOME/.local/state/alacritty/theme.toml"
      ${lib.getExe pkgs.yq} < "$themefile" --raw-output --from-file ${builtins.toFile "parse-theme.jq" ''
        [
          paths(strings) as $p  # iterate over attribute paths to all strings
          | ($p|join(".")) + "=\"" + getpath($p) + "\""  # generate lines like `path.to.attr = "value"`
        ]|.[]  # collect all elements of array as separate values
      ''} | while read -r l; do
        ${lib.getExe pkgs.alacritty} msg config --window-id -1 "$l"
      done
    ''
  ];
}
