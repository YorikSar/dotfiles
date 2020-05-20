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
  ];
  home.packages = with pkgs; [
    gnumake
  ];
}
