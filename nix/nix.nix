{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableNixDirenvIntegration = true;
  };

  home.packages = with pkgs; [
    lorri
  ];
}
