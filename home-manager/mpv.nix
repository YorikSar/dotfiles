{ config, pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    config = {
      alang = "en,eng";
      slang = "en,eng";
    };
  };
}
