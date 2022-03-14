{
  description = "YorikSar's personal configuration files";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      lib = import ./nix/lib {
        inherit nixpkgs home-manager;
      };
    in
    {
      homeConfigurations =
        (lib.hmConfigurations "x86_64-darwin" {
          yorik = ./nix/profiles/home.nix;
          mira = ./nix/profiles/mirantis.nix;
          tweag = ./nix/profiles/tweag.nix;
        }) //
        (lib.hmConfigurations "x86_64-linux" {
          server = ./nix/profiles/base.nix;
        });
    };
}
