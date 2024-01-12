{ config, lib, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  hardware.pulseaudio = {
    enable = false;
    package = pkgs.pulseaudioFull;
    extraConfig = "
  load-module module-switch-on-connect
";
  };
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
}
