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
  };
  home.packages = with pkgs; [
    gotools
    gopls
    dep
    golangci-lint
    clang  # looks like gopls needs this
  ];
}
