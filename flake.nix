{
  description = "YorikSar's personal configuration files";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # latest opensource terraform version
    tf-nixpkgs.url = "github:NixOS/nixpkgs/e12483116b3b51a185a33a272bf351e357ba9a99";
    home-manager = {
      url = "github:nix-community/home-manager/master";
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
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    darwin,
    ...
  } @ inputs: {
    lib = import ./nix/lib inputs;
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
    darwinConfigurations = {
      leya = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [./nix/darwin/leya.nix];
      };
      backup-mac = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./nix/darwin/backup-mac.nix
          home-manager.darwinModules.home-manager
        ];
      };
    };
    checks = let
      hmChecks = self.lib.homeConfigurationsChecks self.homeConfigurations;
      darwinChecks = {
        aarch64-darwin.leya = self.darwinConfigurations.leya.system;
        x86_64-darwin.backup-mac = self.darwinConfigurations.backup-mac.system;
      };
    in
      hmChecks
      // {
        aarch64-darwin = hmChecks.aarch64-darwin // darwinChecks.aarch64-darwin;
        inherit (darwinChecks) x86_64-darwin;
      };
  };
}
