{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ 
                libsForQt5.okular
                ];
  home.file.".config/okularrc".source = ./okularrc;
  home.file.".config/qt5ct/qt5ct.conf".source = ./qt5ct.conf;
  home.file.".config/okularpartrc".source = ./okularpartrc;
  home.file.".local/share/kxmlgui5/okular".source = ./okular;
}
