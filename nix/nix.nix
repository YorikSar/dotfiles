{ config, pkgs, ... }:
let
  rnix-lsp-alejandra =
    let
      src = pkgs.fetchFromGitHub {
        owner = "nix-community";
        repo = "rnix-lsp";
        # https://github.com/nix-community/rnix-lsp/pull/89
        rev = "9189b50b34285b2a9de36a439f6c990fd283c9c7";
        sha256 = "sha256-ZnUtvwkcz7QlAiqQxhI4qVUhtVR+thLhG3wQlle7oZg=";
      };
    in
    pkgs.rnix-lsp.overrideAttrs (old: {
      inherit src;
      cargoDeps = old.cargoDeps.overrideAttrs (old: {
        inherit src;
        outputHash = "sha256-nT+tvOYiqjxLL+bHH/6PMPJbZDg5znaHEJol4LkCBCA=";
      });
      cargoBuildFlags = [ "--no-default-features" "--features" "alejandra" ];
      postInstall = ''
        mv $out/bin/rnix-lsp $out/bin/rnix-lsp-alejandra
      '';
    });
in

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.file.".config/nix/nix.conf".text = ''
    experimental-features = nix-command flakes repl-flake
  '';

  programs.neovim = {
    extraConfig = ''
      let g:LanguageClient_serverCommands['nix'] = ['rnix-lsp']
      command! UseAlejandra call LanguageClient#shutdown()|let g:LanguageClient_serverCommands['nix'] = ['rnix-lsp-alejandra']|call LanguageClient#startServer()
    '';
  };

  home.packages = with pkgs; [
    lorri
    nixUnstable
    rnix-lsp
    rnix-lsp-alejandra
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
