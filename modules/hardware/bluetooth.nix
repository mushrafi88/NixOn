{ config, lib, pkgs, ... }:

{
  hardware.bluetooth={
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez;
    settings = {
      General = {
        ControllerMode = "dual";
        FastConnectable = true;
        Experimental = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
  hardware.pulseaudio = {
    enable = false;
    package = pkgs.pulseaudioFull;
    extraConfig = "
  load-module module-switch-on-connect
";
  };
  services.blueman.enable = true;
}
