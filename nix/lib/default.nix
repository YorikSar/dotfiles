{system, nixpkgs, pkgs, home-manager}: {
  hmConfigurations =
    let
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
}
