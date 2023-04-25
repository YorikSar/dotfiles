{pkgs, ...}: {
  programs.neovim = {
    extraConfig = ''
      let g:LanguageClient_serverCommands['rust'] = ['rust-analyzer']
    '';
    treesitter.grammars = p: [p.rust];
  };
  home.packages = with pkgs; [
    rust-analyzer
  ];
}
