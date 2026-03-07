{pkgs, ...}: {
  programs.neovim = {
    extraConfig = ''
      let g:LanguageClient_serverCommands['rust'] = ['rust-analyzer']
    '';
    plugins = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      rust
      rust.associatedQuery
    ];
  };
  home.packages = with pkgs; [
    rust-analyzer
  ];
}
