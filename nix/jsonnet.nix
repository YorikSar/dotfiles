{ pkgs, ... }:
{
  programs.neovim = {
    initLua = ''
      vim.lsp.enable('jsonnet_ls')
    '';
    extraConfig = ''
      autocmd BufNewFile,BufRead *.jsonnet setf jsonnet
      autocmd BufNewFile,BufRead *.libsonnet setf jsonnet
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
