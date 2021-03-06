{ config, pkgs, ... }:
let
  vim-solarized8 = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-solarized8";
    version = "2019-12-11";
    src = pkgs.fetchFromGitHub {
      owner = "lifepillar";
      repo = "vim-solarized8";
      rev = "5df7666374ead07a482605b53a0f36c27dc17e8d";
      sha256 = "1nvlb00lajzbhfsbsjw6f7hi37xrnyfhf0a7cgjvf3jp2piwjs2d";
    };
  };

in
{
  imports = [
    ./languageclient.nix
  ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./extraConfig.vim;
    plugins = with pkgs.vimPlugins; [
      vim-solarized8
      vim-nix
      vim-dispatch
      vim-fugitive
    ];
  };
}
