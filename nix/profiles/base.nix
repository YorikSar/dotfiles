{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../git.nix
    ../htop.nix
    ../neovim.nix
    ../tmux.nix
    ../zsh.nix
    ../ssh.nix
    ../nix.nix
    ../terraform.nix
  ];
  programs.home-manager.enable = true;
  home.file.".config/nixpkgs/flake.nix".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/github.com/YorikSar/dotfiles/flake.nix";
  home.packages = with pkgs; [
    jq
    du-dust
  ];
}
