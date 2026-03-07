{pkgs, ...}: {
  programs.neovim = {
    extraConfig = ''
      autocmd BufNewFile,BufRead *.jsonnet setf jsonnet
      autocmd BufNewFile,BufRead *.libsonnet setf jsonnet
      let g:LanguageClient_serverCommands['jsonnet'] = ['jsonnet-language-server', '--lint', '--eval-diags']
    '';
    plugins = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      jsonnet
      jsonnet.associatedQuery
    ];
  };
  home.packages = with pkgs; [
    jsonnet-language-server
  ];
}
