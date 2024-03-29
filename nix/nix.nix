{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.file.".config/nix/nix.conf".text = ''
    experimental-features = nix-command flakes repl-flake
  '';

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: [p.nix]))
    ];
  };

  home.packages = with pkgs; [
    lorri
    nixUnstable
    nixos-rebuild
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
