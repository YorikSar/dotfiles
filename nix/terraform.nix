{pkgs, ...}: {
  programs.neovim = {
    extraConfig = ''
      let g:LanguageClient_serverCommands['hcl'] = ['terraform-ls']
    '';
    treesitter.grammars = p: [p.hcl];
  };
  home.packages = with pkgs; [
    terraform-ls
  ];
}
