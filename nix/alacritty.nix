{
  lib,
  pkgs,
  ...
}: let
  alacritty-themes = pkgs.fetchFromGitHub {
    owner = "alacritty";
    repo = "alacritty-theme";
    rev = "6fa0ecf86f885eb15a636f52209791818846d04f";
    sha256 = "sha256-ux/qIbEeCtnNIk2PpvpCiCa2VHGtfVriBQ1wDUWkro8";
  };
in {
  programs.alacritty = {
    enable = true;
    settings = {
      import = [
        "~/.local/state/alacritty/theme.yaml"
      ];
      window.startup_mode = "Fullscreen";
      font.normal.family = "Hack";
    };
  };
  home.activation.alacritty-theme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "$HOME/.local/state/alacritty"
    if [ ! -e  "$HOME/.local/state/alacritty/theme.yaml" ]; then
      $DRY_RUN_CMD ln -s $VERBOSE_ARG "${alacritty-themes}/themes/solarized_dark.yaml" "$HOME/.local/state/alacritty/theme.yaml"
    fi
  '';
  services.dark-mode-notify.onSwitch = [
    ''
      if [ "$DARKMODE" -eq 0 ]; then
        theme=light
      else
        theme=dark
      fi
      themefile="${alacritty-themes}/themes/solarized_''${theme}.yaml"
      ln -fs "$themefile" "$HOME/.local/state/alacritty/theme.yaml"
      ${lib.getExe pkgs.yq} < "$themefile" --raw-output --from-file ${builtins.toFile "parse-theme.jq" ''
        [
          paths(strings) as $p  # iterate over attribute paths to all strings
          | ($p|join(".")) + "=\"" + getpath($p) + "\""  # generate lines like `path.to.attr = "value"`
        ]|.[]  # collect all elements of array as separate values
      ''} | while read -r l; do
        ${lib.getExe pkgs.alacritty} msg config "$l"
      done
    ''
  ];
}
