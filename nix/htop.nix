{ config, pkgs, ... }:

{
  programs.htop = {
    enable = true;
    settings = {
      hide_threads = true;
      left_meters = [
        "LeftCPUs"
        "Memory"
        "Swap"
      ];
      right_meters = [
        "RightCPUs"
        "Tasks"
        "LoadAverage"
        "Uptime"
      ];
    };
  };
}
