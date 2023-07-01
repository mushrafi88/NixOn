{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.libnotify ]; # Dependency
  services.dunst = {
    enable = true;
    iconTheme = {
      # Icons
      name = "Papirus Dark";
      package = pkgs.papirus-icon-theme;
      size = "32x32";
    };
    settings = {
      # Settings
      global = {
        monitor = 0;
        # geometry [{width}x{height}][+/-{x}+/-{y}]
        #geometry = "750x10-15";
        #follow = mouse;
        width = 300;
        height = 250;
        origin = "top-center";
        offset = "0x10";
        shrink = "yes";
        transparency = 0;
        padding = 4;
        horizontal_padding = 4;
        text_icon_padding = 0;
        frame_width = 3;
        frame_color = "#8AADF4";
        separator_color = "frame";
        font = "FiraCode Nerd Font 12";
        line_height = 4;
        idle_threshold = 120;
        markup = "full";
        format = ''<b>%s</b>\n%b'';
        alignment = "center";
        vertical_alignment = "center";
        icon_position = "left";
        word_wrap = "yes";
        ignore_newline = "no";
        show_indicators = "yes";
        sort = true;
        stack_duplicates = true;
        # startup_notification = false;
        notification_height = 0;
        hide_duplicate_count = true;
        max_icon_size = 64;
      };
      urgency_low = {
        # Colors
        background = "#24273A";
        foreground = "#CAD3F5";
        timeout = 4;
        icon = "~/.config/dunst/icon/confused.jpg";
      };
      urgency_normal = {
        background = "#24273A";
        foreground = "#CAD3F5";
        timeout = 4;
        icon = "~/.config/dunst/icon/normal.jpg";
      };
      urgency_critical = {
        background = "#24273A";
        foreground = "#CAD3F5";
        frame_color = "#F5A97F";
        timeout = 10;
        icon = "~/.config/dunst/icon/angry.png";
      };
    };
  };
  xdg.dataFile."dbus-1/services/org.knopwob.dunst.service".source = "${pkgs.dunst}/share/dbus-1/services/org.knopwob.dunst.service";

  home.file.".config/dunst/icon".source = ./icon;
}
