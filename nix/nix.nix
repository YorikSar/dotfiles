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
    nixVersions.latest
    nixos-rebuild
    nix-output-monitor
  ];
}
