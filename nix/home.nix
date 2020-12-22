{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./go.nix
    ./htop.nix
    ./mpv.nix
    ./neovim.nix
    ./tmux.nix
    ./zsh.nix
    ./ssh.nix
    ./openstack
    ./elm.nix
    ./private
    ./nix-upgrade.nix
    ./nix.nix
  ];
  home.packages = with pkgs; [
    gnumake
    watch

    jq
    nodejs

    kubectl
    kubernetes-helm
  ];
}
