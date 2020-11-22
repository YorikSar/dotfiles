{ config, pkgs, ... }:

{
  programs.htop = {
    enable = true;
    hideThreads = true;
    meters = {
      left = [
        "LeftCPUs"
        "Memory"
        "Swap"
        #{ kind = "Battery"; mode = 1; }
      ];
      right = [
        "RightCPUs"
        "Tasks"
        "LoadAverage"
        "Uptime"
      ];
    };
  };
}
