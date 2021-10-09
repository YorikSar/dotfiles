{system, pkgs, home-manager}: {
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
          };
          homeDirectory = "/Users/${name}";
        };
    in
      attrs: builtins.mapAttrs buildConfig attrs;
}
