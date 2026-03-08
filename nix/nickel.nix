{pkgs, ...}: {
  programs.neovim = {
    initLua = ''
      vim.lsp.enable('nickel_ls')
    '';
    plugins = with pkgs.vimPlugins; [
      vim-nickel
    ];
  };
  home.packages = with pkgs; [
    nls
  ];
}
