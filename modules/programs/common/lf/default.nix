{ pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      file
      lf
      ueberzug
      autojump
    ];
  };
  home.file.".config/lf".source = ./config;
}
