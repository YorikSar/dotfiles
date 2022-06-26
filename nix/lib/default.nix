{ nixpkgs, home-manager }:
let
  hmNixpkgsRegistry =
    {
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
in
{
  hmConfigurations = system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      buildConfig = name: profile:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            profile
            hmNixpkgsRegistry
            {
              home = {
                username = name;
                homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${name}" else "/home/${name}";
                stateVersion = "22.05";
              };
            }
          ];
        };
    in
    attrs: builtins.mapAttrs buildConfig attrs;
  homeConfigurationsChecks = cfgs:
    let
      lib = nixpkgs.lib;
    in
    lib.trivial.pipe cfgs [
      # drop everything except activationPackage
      (lib.mapAttrs (name: cfg: cfg.activationPackage))
      # cfgs => [{ system, name, value = activationPackage;}]
      (lib.mapAttrsToList (name: pkg: {
        system = pkg.stdenv.system;
        inherit name;
        value = pkg;
      }))
      # [{ system, name, value}] => {system = [{ system, name, value}]}
      (lib.groupBy (systemNameValue: systemNameValue.system))
      # => { system.name = activationPackage }
      (lib.mapAttrs (system: nameValuePairs: lib.listToAttrs nameValuePairs))
    ];
}
