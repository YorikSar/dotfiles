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

    onSwitchInputs = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = ''
        List of packages that should be available in PATH for onSwitch script.
      '';
    };

    onSwitch = lib.mkOption {
      type = lib.types.lines;
      default = "";
      example = ''
        if [ "$DARKMODE" -eq 0 ]; then
          osascript -e 'display notification "Dark mode is off"'
        else
          osascript -e 'display notification "Dark mode is on"'
        fi
      '';
      description = ''
        Script to execute when dark mode changes.
        The environment variable DARKMODE will be set to either 1 or 0.
      '';
    };

    switchScript = lib.mkOption {
      type = lib.types.package;
      readOnly = true;
      default = pkgs.writeShellApplication {
        name = "dark-mode-onswitch";
        runtimeInputs = cfg.onSwitchInputs;
        text = cfg.onSwitch;
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
