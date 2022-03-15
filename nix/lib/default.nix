{ nixpkgs, home-manager }: {
  hmConfigurations = system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      buildConfig = name: profile:
        home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = name;
          configuration = {
            imports = [
              profile
            ];
            home.file.".config/nix/registry.json".text = builtins.toJSON {
              version = 2;
              flakes = [
                {
                  from = {
                    id = "nixpkgs";
                    type = "indirect";
                  };
                  to = {
                    lastModified = nixpkgs.lastModified;
                    narHash = nixpkgs.narHash;
                    owner = "NixOS";
                    repo = "nixpkgs";
                    rev = nixpkgs.rev;
                    type = "github";
                  };
                }
              ];
            };
          };
          homeDirectory = "/Users/${name}";
        };
    in
    attrs: builtins.mapAttrs buildConfig attrs;
  homeConfigurationsChecks = cfgs:
    nixpkgs.lib.trivial.pipe cfgs [
      # cfgs => [{ system = {name = cfgname; value = cfg.activationPackage;}}]
      (nixpkgs.lib.attrsets.mapAttrsToList (name: cfg: {
        ${cfg.activationPackage.stdenv.system} = {
          inherit name;
          value = cfg.activationPackage;
        };
      }))
      # => { system.cfgname = cfg.activationPackage }
      (nixpkgs.lib.attrsets.zipAttrsWith (name: values: builtins.listToAttrs values))
    ];
}
