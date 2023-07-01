{ pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      qt5ct
    ];
  };
  home.file.".config/qt5ct/colors/Catppuccin-Mocha.conf".source = ./Catppuccin-Mocha.conf;
}
