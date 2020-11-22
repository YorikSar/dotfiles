{ config, pkgs, ... }:

{
  programs.go = {
    enable = true;
    goPath = "go";
  };
  programs.neovim = {
    extraConfig = ''
      let g:LanguageClient_serverCommands['go'] = ['gopls']
    '';
    plugins = with pkgs.vimPlugins; [
      vim-go
    ];
  };
  home.packages = with pkgs; [
    gotools
    gopls
    dep
    golangci-lint
  ];
}
