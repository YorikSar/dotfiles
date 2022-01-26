{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.file.".config/nix/nix.conf".text = ''
    experimental-features = nix-command flakes
  '';

  programs.neovim = {
    extraConfig = ''
      let g:LanguageClient_serverCommands['nix'] = ['rnix-lsp']
    '';
  };

  home.packages = with pkgs; [
    lorri
    nixUnstable
    rnix-lsp
  ];
}
