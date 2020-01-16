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
  ];
  home.packages = with pkgs; [
    gnumake
  ];
}
