{ config, pkgs, ... }:

{
  imports = [
    ../git.nix
    ../go.nix
    ../htop.nix
    ../neovim.nix
    ../tmux.nix
    ../zsh.nix
    ../ssh.nix
    ../nix-upgrade.nix
    ../nix.nix
  ];
  home.packages = with pkgs; [
    gnumake
    watch
    docker

    jq
    nodejs
  ];
}

