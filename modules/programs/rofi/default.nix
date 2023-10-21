{ lib, pkgs, user, ... }:
{
  home.file.".config/rofi/off.sh".source = ./off.sh;
  home.file.".config/rofi/launcher.sh".source = ./launcher.sh;
  home.file.".config/rofi/launcher_theme.rasi".source = ./launcher_theme.rasi;
  home.file.".config/rofi/powermenu.sh".source = ./powermenu.sh;
  home.file.".config/rofi/powermenu_theme.rasi".source = ./powermenu_theme.rasi;
  home.file.".config/rofi/drun.sh".source = ./drun.sh;
  home.file.".config/rofi/drun_theme.rasi".source = ./drun_theme.rasi;
  home.file.".config/rofi/kill_process.sh".source = ./kill_process.sh;
  home.file.".config/rofi/kill_process_theme.rasi".source = ./kill_process_theme.rasi;
  home.file.".config/rofi/launch_with_nvidia.sh".source = ./launch_with_nvidia.sh;



}
