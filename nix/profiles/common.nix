{pkgs, ...}: {
  imports = [
    ./base.nix
    ../go.nix
    ../nix-upgrade.nix
  ];
  home.packages = with pkgs; [
    gnumake
    watch
    docker

    nodejs
  ];
}
