{ config, pkgs, ... }:

let overlay = self: super: {
  mpv = super.mpv.overrideAttrs (oldAttrs: rec {
    version = "0.31.0";
    src = super.pkgs.fetchFromGitHub {
      owner  = "mpv-player";
      repo   = "mpv";
      rev    = "v${version}";
      sha256 = "138m09l4wi6ifbi15z76j578plmxkclhlzfryasfcdp8hswhs59r";
    };
  });
};
in
{
  programs.mpv = {
    enable = true;
    config = {
      alang = "en,eng";
      slang = "en,eng";
    };
  };
  nixpkgs.overlays = [overlay];
}
