{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-beancount
      (nvim-treesitter.withPlugins (p: [p.beancount]))
    ];
  };
  home.packages = with pkgs; [
    beancount
    fava
  ];
}
