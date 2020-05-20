{ config, pkgs, ... }:

{
  programs.go = {
    enable = true;
    goPath = "go";
  };
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-go
    ];
  };
  home.packages = with pkgs; [
    gotools
    dep
  ];
}
