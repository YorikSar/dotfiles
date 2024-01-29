{
  pkgs,
  lib,
  ...
}: let
  xcrun-subst = pkgs.writeShellScriptBin "xcrun-subst" ''echo "$(basename $0) is not installed"; exit 1;'';
  veryLowPrio = lib.setPrio 1000;
  xcrun-subst-all = veryLowPrio (pkgs.runCommand "xcrun-subst-all" {} (
    ''
      mkdir -p $out/bin
    ''
    + (builtins.concatStringsSep "\n"
      (map (n: "ln -s ${xcrun-subst}/bin/xcrun-subst $out/bin/${n}")
        (lib.strings.splitString "\n" (builtins.readFile ./xcrun-subst.lst))))
  ));
in {
  home.packages = [
    xcrun-subst-all
  ];
  # Some tools still try to execute these directly, so force xcrun to fail for them
  programs.zsh.sessionVariables.DEVELOPER_DIR = "/no/xcode/tools/installed";
}
