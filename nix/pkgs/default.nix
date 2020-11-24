let
  sources = import ../sources.nix;
  overlay = self: super: {
    home-manager = super.callPackage ./home-manager { inherit sources; pkgs = self; };
  };
in
  import sources.nixpkgs {
    overlays = [ overlay ];
  }
