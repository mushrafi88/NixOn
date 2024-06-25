{ lib, user, pkgs, config, ... }:
{
  programs.yazi = {
    enable = true;
  };
  home = {
    packages = with pkgs; [ 
      file
      unar 
      ffmpegthumbnailer
      ueberzugpp
      autojump
      imagemagick
      #poppler
      #wkhtmltopdf
      chafa
      catdoc
      exiftool
      ctpv
      elinks
      jq
      poppler_utils
      mdcat
      zoxide
    ];
  };
  home.file.".config/yazi/yazi.toml".source = ./yazi/yazi.toml;
  home.file.".config/yazi/theme.toml".source = ./yazi/theme.toml;
  home.file.".config/yazi/keymap.toml".source = ./yazi/keymap.toml;
  home.file.".config/yazi/flavors/catppuccin-mocha.yazi".source = ./yazi/flavors/catppuccin-mocha.yazi;
}
