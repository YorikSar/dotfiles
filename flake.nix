{
  description = "YorikSar's personal configuration files";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:YorikSar/home-manager/nvim-treesitter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nickel.url = "github:tweag/nickel";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    darwin,
    nickel,
    ...
  }: {
    lib = import ./nix/lib {
      inherit nixpkgs home-manager nickel;
    };
    homeProfiles = with nixpkgs.lib;
      listToAttrs (map
        (
          fileName:
            nameValuePair (removeSuffix ".nix" fileName) (import ./nix/profiles/${fileName})
        )
        (attrNames (builtins.readDir ./nix/profiles)));
    homeConfigurations = self.lib.hmConfigurations "aarch64-darwin" {
      yorik = self.homeProfiles.home;
      mira = self.homeProfiles.mirantis;
      tweag = self.homeProfiles.tweag;
    };
    darwinConfigurations.leya = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [./nix/darwin/leya.nix];
    };
    checks = let
      hmChecks = self.lib.homeConfigurationsChecks self.homeConfigurations;
      darwinChecks = {
        aarch64-darwin.leya = self.darwinConfigurations.leya.system;
      };
    in
      hmChecks
      // {
        aarch64-darwin = hmChecks.aarch64-darwin // darwinChecks.aarch64-darwin;
      };
  };
}
