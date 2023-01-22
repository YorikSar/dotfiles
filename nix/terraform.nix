{pkgs, ...}: {
  programs.neovim = {
    extraConfig = ''
      let g:LanguageClient_serverCommands['hcl'] = ['terraform-ls']
    '';
    treeSitterPlugins = p: [p.hcl];
  };
  home.packages = with pkgs; [
    terraform-ls
  ];
}
