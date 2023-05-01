{pkgs, ...}: {
  programs.neovim = {
    extraConfig = ''
      let g:LanguageClient_serverCommands['hcl'] = ['terraform-ls']
    '';
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: [p.hcl]))
    ];
  };
  home.packages = with pkgs; [
    terraform-ls
  ];
}
