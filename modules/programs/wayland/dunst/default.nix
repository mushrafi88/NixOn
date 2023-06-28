{ config, lib, pkgs, ... }:

let
  colors = import ./dunst_colors.nix; # Import colors theme
in
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
    settings = with colors.scheme.doom; {
      # Settings
      global = {
        monitor = 0;
        # geometry [{width}x{height}][+/-{x}+/-{y}]
        # geometry = "600x50-50+65";
        #follow = mouse;
        #width = 300;
        #height = 200;
        origin = "top-right";
        offset = "50x50";
        shrink = "yes";
        transparency = 0;
        padding = 4;
        horizontal_padding = 4;
        text_icon_padding = 0;
        frame_width = 3;
        frame_color = "#${bg}";
        separator_color = "frame";
        font = "FiraCode Nerd Font 12";
        line_height = 4;
        idle_threshold = 120;
        markup = "full";
        format = ''<b>%s</b>\n%b'';
        alignment = "center";
        vertical_alignment = "center";
        icon_position = "top";
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
        background = "#${bg}";
        foreground = "#${text}";
        timeout = 4;
        icon = "~/.config/dunst/icon/confused.jpg";
      };
      urgency_normal = {
        background = "#${bg}";
        foreground = "#${text}";
        timeout = 4;
        icon = "~/.config/dunst/icon/normal.jpg";
      };
      urgency_critical = {
        background = "#${bg}";
        foreground = "#${text}";
        frame_color = "#${red}";
        timeout = 10;
        icon = "~/.config/dunst/icon/angry.png";
      };
    };
  };
  xdg.dataFile."dbus-1/services/org.knopwob.dunst.service".source = "${pkgs.dunst}/share/dbus-1/services/org.knopwob.dunst.service";

  home.file.".config/dunst/icon".source = ./config/icon;
}
