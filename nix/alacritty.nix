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
        "${alacritty-themes}/themes/solarized_dark.yaml"
      ];
      window.startup_mode = "Fullscreen";
      font.normal.family = "Hack";
    };
  };
  services.dark-mode-notify.onSwitch = ''
    if [ "$DARKMODE" -eq 0 ]; then
      theme=light
    else
      theme=dark
    fi
    ${lib.getExe pkgs.yq} < ${alacritty-themes}/themes/solarized_''${theme}.yaml --raw-output --from-file ${builtins.toFile "parse-theme.jq" ''
      [
        paths(strings) as $p  # iterate over attribute paths to all strings
        | ($p|join(".")) + "=\"" + getpath($p) + "\""  # generate lines like `path.to.attr = "value"`
      ]|.[]  # collect all elements of array as separate values
    ''} | while read -r l; do
      ${lib.getExe pkgs.alacritty} msg config "$l"
    done
  '';
}
