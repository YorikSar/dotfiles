{ config, pkgs, ... }:
let
  # From https://github.com/NixOS/nixpkgs/issues/168984#issuecomment-1109119619
  golangci-lint-117 = pkgs.golangci-lint.override ({
    # Override https://github.com/NixOS/nixpkgs/pull/166801 which changed this
    # to buildGo118Module because it does not build on Darwin.
    buildGoModule = pkgs.buildGoModule;
  });
in

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
    golangci-lint-117
    clang # looks like gopls needs this
  ];
}
