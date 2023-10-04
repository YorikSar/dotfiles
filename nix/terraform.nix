{pkgs, ...}: {
  programs.neovim = {
    extraConfig = ''
      let g:LanguageClient_serverCommands['hcl'] = ['terraform-ls','serve']
      let g:LanguageClient_serverCommands['terraform'] = ['terraform-ls','serve']
      let g:LanguageClient_serverCommands['terraform-vars'] = ['terraform-ls','serve']
    '';
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: [p.hcl p.terraform]))
    ];
  };
  home.packages = with pkgs; [
    terraform
    terraform-ls
  ];
}
