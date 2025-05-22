{ pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      libsForQt5.qt5ct
    ];
  };
  home.file.".config/qt5ct/colors/Catppuccin-Mocha.conf".source = ./Catppuccin-Mocha.conf;
}
