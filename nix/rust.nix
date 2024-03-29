{pkgs, ...}: {
  programs.neovim = {
    extraConfig = ''
      let g:LanguageClient_serverCommands['rust'] = ['rust-analyzer']
    '';
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: [p.rust]))
    ];
  };
  home.packages = with pkgs; [
    rust-analyzer
  ];
}
