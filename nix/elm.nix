{ pkgs, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-elm-syntax
    ];
    initLua = ''
      vim.lsp.enable('emlls')
    '';
  };
  home.packages = with pkgs.elmPackages; [
    elm
    elm-format
    elm-test
    elm-upgrade
    elm-language-server
    pkgs.nodePackages."uglify-js"
  ];
}
