{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-beancount
    ];
    treeSitterPlugins = p: [p.beancount];
  };
  home.packages = with pkgs; [
    beancount
    fava
  ];
}
