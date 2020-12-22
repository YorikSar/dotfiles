{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    # openstack is not compatible with latest nixpkgs
    #../openstack
    ../private/work.nix
  ];
  home.packages = with pkgs; [
    awscli
    go-jira
    kubectl
    kubernetes-helm
  ];
}
