{ pkgs, lib, ... }:
{
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
      "pipe-operators"
    ];
  };

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.nix.associatedQuery
      direnv-vim
    ];
  };

  home.packages = with pkgs; [
    nixVersions.latest
    nixos-rebuild
    nix-output-monitor
  ];
}
