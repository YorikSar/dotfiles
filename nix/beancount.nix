{ config, pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-beancount
    ];
  };
  home.packages = with pkgs; [
    beancount
    fava
  ];
}
