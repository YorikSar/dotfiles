{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-elm-syntax
    ];
    extraConfig = ''
      let g:LanguageClient_serverCommands['elm'] = ['elm-language-server']
      let g:LanguageClient_rootMarkers['elm'] = ['elm.json']
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
