{ config, pkgs, ... }:

{
  programs.htop = {
    enable = true;
    settings = {
      hide_userland_threads = true;
      column_meters_0 = [
        "LeftCPUs2"
        "Memory"
        "Swap"
      ];
      column_meters_1 = [
        "RightCPUs2"
        "Tasks"
        "LoadAverage"
        "Uptime"
      ];
    };
  };
}
