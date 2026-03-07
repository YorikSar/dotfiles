{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-beancount
      nvim-treesitter-parsers.beancount
      nvim-treesitter-parsers.beancount.associatedQuery
    ];
  };
  home.packages = with pkgs; [
    beancount
    fava
  ];
}
