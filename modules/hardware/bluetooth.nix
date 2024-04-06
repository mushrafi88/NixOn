{ config, lib, pkgs, ... }:

{
  hardware.bluetooth={
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez-experimental;
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

  services.blueman.enable = true;
}
