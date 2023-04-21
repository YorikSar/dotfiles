{pkgs, ...}: let
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
}
