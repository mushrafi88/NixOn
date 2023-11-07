{ pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      mpvpaper
    ];
  };
}
