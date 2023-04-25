{pkgs, ...}: let
  rnix-lsp-alejandra = let
    src = pkgs.fetchFromGitHub {
      owner = "nix-community";
      repo = "rnix-lsp";
      # https://github.com/nix-community/rnix-lsp/pull/89
      rev = "936ae39a1a63f39f47a36f3be32100e5343e2cb7";
      sha256 = "sha256-f6tRwuMUQcuhxDuQN78b1YNYIiIrEFS5sGfLFUTbw+E=";
    };
  in
    pkgs.rnix-lsp.overrideAttrs (old: {
      inherit src;
      cargoDeps = old.cargoDeps.overrideAttrs (old: {
        inherit src;
        outputHash = "sha256-pzJwIx9xY1sBGnAxr2An55npoWWIdZkfX/GItMUsJmE=";
      });
      cargoBuildFlags = ["--no-default-features" "--features" "alejandra"];
      postInstall = ''
        mv $out/bin/rnix-lsp $out/bin/rnix-lsp-alejandra
      '';
    });
in {
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
    treesitter.grammars = p: [p.nix];
  };

  home.packages = with pkgs; [
    lorri
    nixUnstable
    nixos-rebuild
    rnix-lsp
    rnix-lsp-alejandra
    nix-output-monitor
  ];

  launchd = {
    enable = pkgs.stdenv.hostPlatform.isDarwin;
    agents.lorri = {
      enable = true;
      config = {
        ProgramArguments = ["${pkgs.lorri}/bin/lorri" "daemon"];
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
