{ config, lib, pkgs, ... }:

{
  hardware.bluetooth.enable = false;
  services.blueman.enable = false;
}
