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

  launchd = {
    enable = pkgs.stdenv.hostPlatform.isDarwin;
    agents.lorri = {
      enable = true;
      config = {
        ProgramArguments = [ "${pkgs.lorri}/bin/lorri" "daemon" ];
        StandardOutPath = "/var/tmp/lorri.log";
        StandardErrorPath = "/var/tmp/lorri.log";
        KeepAlive = true;
        RunAtLoad = true;
        EnvironmentVariables = {
          PATH = "${pkgs.nixUnstable}/bin";
        };
      };
    };
  };
}
