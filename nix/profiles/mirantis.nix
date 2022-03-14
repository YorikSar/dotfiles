{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./macos.nix
    # openstack is not compatible with latest nixpkgs
    #../openstack
    ../private/mirantis.nix
  ];
  home.packages = with pkgs; [
    awscli
    go-jira
    kubectl
    kubernetes-helm
  ];
}
