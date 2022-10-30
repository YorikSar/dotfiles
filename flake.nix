{
  description = "YorikSar's personal configuration files";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    {
      lib = import ./nix/lib {
        inherit nixpkgs home-manager;
      };
      homeProfiles = with nixpkgs.lib; listToAttrs (map
        (fileName:
          nameValuePair (removeSuffix ".nix" fileName) (import ./nix/profiles/${fileName})
        )
        (attrNames (builtins.readDir ./nix/profiles)));
      homeConfigurations =
        (self.lib.hmConfigurations "aarch64-darwin" {
          yorik = self.homeProfiles.home;
          mira = self.homeProfiles.mirantis;
          tweag = self.homeProfiles.tweag;
        }) //
        (self.lib.hmConfigurations "x86_64-linux" {
          ytaraday = self.homeProfiles.base;
        });
      checks = self.lib.homeConfigurationsChecks self.homeConfigurations;
    };
}
