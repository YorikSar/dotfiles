{
  description = "YorikSar's personal configuration files";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager}:
    let
      system = "x86_64-darwin";
      pkgs = import nixpkgs {
        inherit system;
      };
      lib = import ./nix/lib {
        inherit system pkgs home-manager;
      };
    in {
      homeConfigurations = lib.hmConfigurations {
        yorik = ./nix/profiles/home.nix;
        ytaraday = ./nix/profiles/work.nix;
        tweag = ./nix/profiles/tweag.nix;
      };
    };
}
