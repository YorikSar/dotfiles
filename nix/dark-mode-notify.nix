{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.dark-mode-notify;
in {
  options.services.dark-mode-notify = {
    enable = lib.mkEnableOption "dark-mode-notify service";

    package =
      (lib.mkPackageOption pkgs "dark-mode-notify" {})
      // {
        default = pkgs.callPackage pkgs/dark-mode-notify.nix {};
      };

    onSwitch = lib.mkOption {
      type = lib.types.listOf lib.types.lines;
      default = [];
      example = [
        ''
          if [ "$DARKMODE" -eq 0 ]; then
            osascript -e 'display notification "Dark mode is off"'
          else
            osascript -e 'display notification "Dark mode is on"'
          fi
        ''
      ];
      description = ''
        List of scripts to execute when dark mode changes.
        The environment variable DARKMODE will be set to either 1 or 0.
      '';
    };

    switchScript = lib.mkOption {
      type = lib.types.package;
      readOnly = true;
      default = pkgs.writeShellApplication {
        name = "dark-mode-onswitch";
        text = lib.concatStringsSep "\n" (map (script: "${lib.getExe (pkgs.writeShellApplication {
            name = "dark-mode-onswitch-script.sh";
            text = script;
          })} || true")
          cfg.onSwitch);
      };
    };
  };

  config = lib.mkIf cfg.enable {
    launchd.agents.dark-mode-notify = {
      enable = true;
      config = {
        ProgramArguments = [
          (lib.getExe cfg.package)
          (lib.getExe cfg.switchScript)
        ];
        KeepAlive = {
          Crashed = true;
          SuccessfulExit = false;
        };
        ProcessType = "Background";
      };
    };
  };
}
