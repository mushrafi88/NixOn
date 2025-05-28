{ config, lib, pkgs, ... }:

{
  imports = [
    (import ../../environment/hypr-variables.nix)
  ];
  programs = {
    zsh = {
      initContent = '' 
			if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then 
				exec  Hyprland 
			fi 
			'';
    };
    bash = {
      initExtra = '' 
			if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then  
				exec  Hyprland
            fi '';
    };
  };
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      "$mainMod" = "SUPER";

      monitor = "eDP-1, 1920x1080, 1920x0, 1";

      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      input = {
        kb_layout = "us";
        kb_options = "caps:escape";
        
        follow_mouse = 1;
        float_switch_override_focus = 1;
        numlock_by_default = true;
        
        touchpad = {
          natural_scroll = false;
          drag_lock = true;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        "col.active_border" = "rgb(80d4ff)";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle"; 
      };

      dwindle = {
        force_split = 0;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0; 
        use_active_for_splits = true;
        pseudotile = true;
        preserve_split = true; 
      };

      master = {
        new_status = "master"; 
        special_scale_factor = 0.8;
      };


      decoration = {
        active_opacity = 1.0; 
        inactive_opacity = 1.0; 
        fullscreen_opacity = 1.0; 
        rounding = 1; 

        blur = {
          enabled = false;
          size = 1;
          passes = 3;
          new_optimizations = true;
          xray = true; 
          ignore_opacity = false;
        }; 
        dim_inactive = false;
      };

      animations = {
        enabled = true;

        bezier = "overshot, 0.13, 0.99, 0.29, 1.1";
        # bezier = "myBezier, 0.33, 0.82, 0.9, -0.08";

        animation = [
          "windows,     1, 4,  overshot, slide"
          "windowsOut,  1, 7,  default, popin 80%"
          "border,      1, 10, default"
          "borderangle, 1, 8,  default"
          "fade,        1, 7,  default"
          "workspaces,  1, 6,  default"
        ];
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 4;
        workspace_swipe_invert = true;
        workspace_swipe_distance = 250;
        workspace_swipe_forever = true;
        workspace_swipe_min_speed_to_force = 15; 
        workspace_swipe_cancel_ratio = 0.5; 
        workspace_swipe_create_new = false;
      };

      misc = {
        always_follow_on_dnd= true; 
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        render_ahead_of_time = false;
        disable_hyprland_logo = true;
      };

        windowrule = [
        "fullscreen, title:^(mpv)$"
        "fullscreen, title:^(swayimg)$"
        "float, title:^(mpv)$"
        "move 25%-,title:pcmanfm"
        "size 960 540,title:pcmanfm"
        "animation slide right,title:kitty"
        "workspace 9 silent, title:Discord"
        "float,title:ncmpcpp"
        "move 25%-,title:ncmpcpp"
        "size 960 540,title:ncmpcpp"
        "float, title:calcurse"
        "move 25%-,title:calcurse"
        "size 960 540,title:calcurse"
        "float, title:termfloat"
        "move 25%-,title:termfloat"
        "size 960 540,title:termfloat"
        "rounding 5,title:termfloat"
      ];

      windowrulev2 = [
      "workspace 9 silent, title:Telegram"
      "workspace 2 silent,class:^(obsidian)$"
      "workspace 3,class:^(firefox)$"
      "workspace 4,class:^(org.kde.okular)$"
      "workspace 10 silent,class:^(transmission-gtk)$"
      "workspace 9 silent,class:^(discord)$"
      "opacity 0.95 0.95,class:^(kitty)$"
      ];

      exec-once = [
        "launch_waybar"
        "nm-applet --indicator"
        "transmission-gtk"
        "wallpaper_start"
        "wl-copy"
        "volume_warning"
        "battery_warning"
        "yt_music"
        "snippets_cp"
      ];

      bind = [
        "$mainMod, Return, exec, kitty"
        "CTRL ALT, t, exec, kitty --class='termfloat' "
        "CTRL, q, killactive,"
        "CTRL ALT, q, exit"
        "$mainMod, Space, togglefloating,"
        "$mainMod,f,fullscreen"
        "$mainMod,y,pin"
        "$mainMod, p, pseudo," # dwindle
        "$mainMod, J, togglesplit,"

        # Move focus with mainMod + arrow keys
        "$mainMod, left,  movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up,    movefocus, u"
        "$mainMod, down,  movefocus, d"

        # Moving windows
        "$mainMod SHIFT, left,  swapwindow, l"
        "$mainMod SHIFT, right, swapwindow, r"
        "$mainMod SHIFT, up,    swapwindow, u"
        "$mainMod SHIFT, down,  swapwindow, d"

        # Window resizing                     X  Y
        "$mainMod CTRL, left,  resizeactive, -60 0"
        "$mainMod CTRL, right, resizeactive,  60 0"
        "$mainMod CTRL, up,    resizeactive,  0 -60"
        "$mainMod CTRL, down,  resizeactive,  0  60"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "CTRL ALT, RIGHT, workspace, e+1"
        "CTRL ALT, LEFT, workspace, e-1"

        # Volume and Media Control
        ", XF86AudioRaiseVolume, exec, pamixer -i 5 "
        ", XF86AudioLowerVolume, exec, pamixer -d 5 "
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioMicMute, exec, pamixer --default-source -m"
        
        # Brightness control
        ", XF86MonBrightnessDown, exec, light -U 5 "
        ", XF86MonBrightnessUp, exec, light -A 5 "
        ",XF86AudioPlay,exec, mpc -q toggle "
        ",XF86AudioNext,exec, mpc -q next "
        ",XF86AudioPrev,exec, mpc -q prev"
        # Waybar
        "$mainMod, B, exec, pkill -SIGUSR1 waybar"
        "$mainMod, W, exec, pkill -SIGUSR2 waybar"

        #dunst 
        "CTRL SHIFT,SPACE,exec, dunstctl close-all"
        "CTRL, SPACE,exec, dunstctl close"

        #quick launch 
        "CTRL ALT,F,exec, firefox"
        "CTRL ALT,L,exec,myswaylock"
        "CTRL ALT,P,exec,grimblast --notify  copysave area ~/Pictures/Screenshot/$(date '+%Y-%m-%d'T'%H:%M:%S').png"
        "$mainMod,A,exec,grimblast --notify copysave output ~/Pictures/Screenshot/$(date '+%Y-%m-%d'T'%H:%M:%S').png"
        "$mainMod,r,exec, pkill rofi || ~/.config/rofi/launcher.sh"
      	"$mainMod,t,exec, pkill rofi || ~/.config/rofi/launch_with_nvidia.sh"
        "$mainMod,x,exec, bash ~/.config/rofi/powermenu.sh"
        "CTRL ALT,B,exec,bluetooth_headphone"
        "$mainMod,e,exec, bash ~/.config/rofi/drun.sh"
        "$mainMod,n,exec, wallpaper_next"
        "$mainMod,m,exec, wallpaper_prev"
        "CTRL ALT,K,exec, bash ~/.config/rofi/kill_process.sh"
        "CTRL ALT, h, exec, kitty yazi"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
