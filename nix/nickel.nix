{
  pkgs,
  nickel,
  ...
}: {
  programs.neovim = {
    extraConfig = ''
      let g:LanguageClient_serverCommands['nickel'] = ['nls']
    '';
    plugins = with pkgs.vimPlugins; [
      vim-nickel
    ];
  };
  home.packages = [
    nickel.packages.${pkgs.system}.lsp-nls
  ];
}
