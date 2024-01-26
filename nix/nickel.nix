{pkgs, ...}: {
  programs.neovim = {
    extraConfig = ''
      let g:LanguageClient_serverCommands['nickel'] = ['nls']
    '';
    plugins = with pkgs.vimPlugins; [
      vim-nickel
    ];
  };
  home.packages = with pkgs; [
    nls
  ];
}
