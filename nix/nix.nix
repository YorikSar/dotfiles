{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  nix = {
    package = pkgs.nixVersions.latest;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: [p.nix]))
      direnv-vim
    ];
  };

  home.packages = with pkgs; [
    lorri
    nixVersions.latest
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
          PATH = "${pkgs.nixVersions.latest}/bin";
        };
      };
    };
  };
}
