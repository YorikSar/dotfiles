{
  pkgs,
  inputs,
  ...
}: {
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
  home.packages = with inputs.tf-nixpkgs.legacyPackages.${pkgs.system}; [
    terraform
    terraform-ls
  ];
}
