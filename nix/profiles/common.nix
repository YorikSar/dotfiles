{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./base.nix
    ../go.nix
    ../nix-upgrade.nix
  ];
  home.file.".config/home-manager/flake.nix".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/github.com/YorikSar/dotfiles/flake.nix";
  home.packages = with pkgs; [
    gnumake
    watch
    docker

    nodejs
  ];
}
