{
  pkgs,
  lib,
  ...
}: let
  mosh = pkgs.mosh.overrideAttrs (old: {
    patches = builtins.filter (p: !(lib.hasSuffix "ssh_path.patch" p)) old.patches;
  });
in {
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPath = "~/.ssh/%C.ctl";
    controlPersist = "yes";
    serverAliveInterval = 5;
    userKnownHostsFile = "~/.ssh/known_hosts ~/.ssh/hm_known_hosts";
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github.com";
      };
    };
  };
  home.file.".ssh/hm_known_hosts".text = ''
    github.com,140.82.118.4 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
    github.com,140.82.118.4 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
    github.com,140.82.118.4 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
    lon1.tmate.io ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTnCMAanvAYXe8RSbSgpz2agNiU2i2Y2ryPWeFx+yh473Aj0zW6x/BzApOn5k4qiPmf8LOVSIk5hL01W8l2y5yHC2CXFyBpQuc/uNZzLpAxrvTSVN1rp7hu3dR5keybHFdd8SEWlPI4m9vPYUVqXMrXBjfsSZxeYOUKNav3aWWPGtO19KhmCdMbIZx3PN0QvklhkJ2ElRZO7uiACvvCWS8LOo3ht/Y6QdGIfQqTX3DJlFXwfvnoqhlmV8LGVKk/y6jtqPmmengEEHtvRcH92LzBIR5e0NQj+5/WDHquh1p9xiaA3TZD6zStWSrbqFovm7aAAM9WKfb866WkUK1HlNv
    sfo2.tmate.io ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTnCMAanvAYXe8RSbSgpz2agNiU2i2Y2ryPWeFx+yh473Aj0zW6x/BzApOn5k4qiPmf8LOVSIk5hL01W8l2y5yHC2CXFyBpQuc/uNZzLpAxrvTSVN1rp7hu3dR5keybHFdd8SEWlPI4m9vPYUVqXMrXBjfsSZxeYOUKNav3aWWPGtO19KhmCdMbIZx3PN0QvklhkJ2ElRZO7uiACvvCWS8LOo3ht/Y6QdGIfQqTX3DJlFXwfvnoqhlmV8LGVKk/y6jtqPmmengEEHtvRcH92LzBIR5e0NQj+5/WDHquh1p9xiaA3TZD6zStWSrbqFovm7aAAM9WKfb866WkUK1HlNv
  '';
  home.packages = [
    mosh
  ];
  # Required to build mosh, see https://github.com/NixOS/nixpkgs/pull/350035
  nixpkgs.overlays = [
    (final: prev: {
      abseil-cpp_202407 = prev.abseil-cpp_202407.overrideAttrs {
        patches = [
          # Don't match -Wnon-virtual-dtor in the "flags are needed to suppress
          # Needed to cleanly apply the #1738 fix below.
          # https://github.com/abseil/abseil-cpp/issues/1737
          (final.fetchpatch {
            url = "https://github.com/abseil/abseil-cpp/commit/9cb5e5d15c142e5cc43a2c1db87c8e4e5b6d38a5.patch";
            hash = "sha256-PTNmNJMk42Omwek0ackl4PjxifDP/+GaUitS60l+VB0=";
          })

          # Fix shell option group handling in pkgconfig files
          # https://github.com/abseil/abseil-cpp/pull/1738
          (final.fetchpatch {
            url = "https://github.com/abseil/abseil-cpp/commit/bd0c9c58cac4463d96b574de3097422bb78215a8.patch";
            hash = "sha256-fB9pvkyNBXoDKLrVaNwliqrWEPTa2Y6OJMe2xgl5IBc=";
          })
        ];
      };
    })
  ];
}
