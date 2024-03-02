{pkgs, ...}: {
  imports = [
    ../git.nix
    ../gh.nix
    ../htop.nix
    ../neovim.nix
    ../tmux.nix
    ../zsh.nix
    ../ssh.nix
    ../nix.nix
    ../terraform.nix
    ../dark-mode-notify.nix
    ../nix-index.nix
  ];
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    jq
    du-dust
  ];
}
