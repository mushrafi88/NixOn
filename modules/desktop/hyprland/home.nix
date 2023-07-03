{ config, lib, pkgs, ... }:

{
  imports = [
    (import ../../environment/hypr-variables.nix)
  ];
  programs = {
    zsh = {
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           exec  Hyprland
        fi
      '';
    };
    bash = {
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           exec  Hyprland
        fi
      '';
    };
  };
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    nvidiaPatches = false;
    extraConfig = ''
                                                                         $mainMod = SUPER
                                                                         # $scripts=$HOME/.config/hypr/scripts

                                                                         # monitor=,preferred,auto,1 
                                                                         monitor=HDMI-A-1, 1920x1080, 0x0, 1
                                                                         monitor=eDP-1, 1920x1080, 1920x0, 1

                                                                         # Source a file (multi-file configs)
                                                                         # source = ~/.config/hypr/myColors.conf

                                                                         input {
                                                                           kb_layout = us
                                                                           kb_variant =
                                                                           kb_model =
                                                                           kb_options = caps:escape
                                                                           kb_rules =

                                                                           follow_mouse = 1 # 0|1|2|3
                                                                           float_switch_override_focus = 1
                                                                           numlock_by_default = true

                                                                           touchpad {
                                                                           disable_while_typing = true 
                                                                           natural_scroll = false 
                                                                           scroll_factor = 1.0
                                                                           middle_button_emulation = false 
                                                                           clickfinger_behavior = false 
                                                                           tap-to-click = true 
                                                                           drag_lock = true 
                                                                           }

                                                                           sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
                                                                         }

                                                                         general {
                                                                           gaps_in = 0 
                                                                           gaps_out = 0 
                                                                           border_size = 1
                                                                           col.active_border = rgb(80d4ff)
                                                                          # col.inactive_border = rgba(595959aa)

                                                                           layout = dwindle # master|dwindle 
                                                                         }

                                                                         dwindle {
                                                                           no_gaps_when_only = false
                                                                           force_split = 0 
                                                                           special_scale_factor = 0.8
                                                                           split_width_multiplier = 1.0 
                                                                           use_active_for_splits = true
                                                                           pseudotile = yes 
                                                                           preserve_split = yes 
                                                                         }

                                                                         master {
                                                                           new_is_master = true
                                                                           special_scale_factor = 0.8
                                                                           new_is_master = true
                                                                           no_gaps_when_only = false
                                                                         }

                                                                         # cursor_inactive_timeout = 0
                                                                         decoration {
                                                                           multisample_edges = true
                                                                           active_opacity = 0.95 
                                                                           inactive_opacity = 0.93 
                                                                           fullscreen_opacity = 1.0
                                                                           rounding = 1
                                                                           blur = yes 
                                                                           blur_size = 1
                                                                           blur_passes = 3
                                                                           blur_new_optimizations = true
                                                                           blur_xray = true

                                                                           drop_shadow = false
                                                                           shadow_range = 4
                                                                           shadow_render_power = 3
                                                                           shadow_ignore_window = true
                                                                         # col.shadow = 
                                                                         # col.shadow_inactive
                                                                         # shadow_offset
                                                                           dim_inactive = false
                                                                         # dim_strength = #0.0 ~ 1.0
                                                                           blur_ignore_opacity = false
                                                                           col.shadow = rgba(1a1a1aee)
                                                                         }

                                                                         animations {
                                                                           enabled=1
                                                                           bezier = overshot, 0.13, 0.99, 0.29, 1.1
                                                                           animation = windows, 1, 4, overshot, slide
                                                                           animation = windowsOut, 1, 5, default, popin 80%
                                                                           animation = border, 1, 5, default
                                                                           animation = fade, 1, 8, default
                                                                           animation = workspaces, 1, 6, overshot, slidevert
                                                                         }

                                                                         gestures {
                                                                           workspace_swipe = true
                                                                           workspace_swipe_fingers = 4
                                                                           workspace_swipe_distance = 250
                                                                           workspace_swipe_invert = true
                                                                           workspace_swipe_min_speed_to_force = 15
                                                                           workspace_swipe_cancel_ratio = 0.5
                                                                           workspace_swipe_create_new = false
                                                                         }

                                                                         misc {
                                                                           disable_autoreload = true
                                                                           disable_hyprland_logo = true
                                                                           always_follow_on_dnd = true
                                                                           layers_hog_keyboard_focus = true
                                                                           animate_manual_resizes = false
                                                                           enable_swallow = true
                                                                           swallow_regex =
                                                                           focus_on_activate = true
                                                                         }

                                                                         device:epic mouse V1 {
                                                                           sensitivity = -0.5
                                                                         }

                                                                         bind = $mainMod, Return, exec, kitty
                                                                         bind = CTRL ALT, t, exec, kitty --class="termfloat"
                                                                         bind = CTRL, q, killactive,
                                                                         bind = CTRL ALT, q, exit,
                                                                         bind = $mainMod, Space, togglefloating,
                                                                         bind = $mainMod,f,fullscreen
                                                                         bind = $mainMod,y,pin
                                                                         bind = $mainMod, p, pseudo, # dwindle
                                                                         bind = $mainMod, J, togglesplit, # dwindle

                                                                         #-----------------------#
                                                                         # Toggle grouped layout #
                                                                         #-----------------------#
                                                                         bind = $mainMod, K, togglegroup,
                                                                         bind = $mainMod, Tab, changegroupactive, f

                                                                         #------------#
                                                                         # change gap #
                                                                         #------------#
                                                                         bind = $mainMod SHIFT, G,exec,hyprctl --batch "keyword general:gaps_out 5;keyword general:gaps_in 3"
                                                                         bind = $mainMod , G,exec,hyprctl --batch "keyword general:gaps_out 0;keyword general:gaps_in 0"

                                                                         #--------------------------------------#
                                                                         # Move focus with mainMod + arrow keys #
                                                                         #--------------------------------------#
                                                                         bind = $mainMod, left, movefocus, l
                                                                         bind = $mainMod, right, movefocus, r
                                                                         bind = $mainMod, up, movefocus, u
                                                                         bind = $mainMod, down, movefocus, d

                                                                         #----------------------------------------#
                                                                         # Switch workspaces with mainMod + [0-9] #
                                                                         #----------------------------------------#
                                                                         bind = $mainMod, 1, workspace, 1
                                                                         bind = $mainMod, 2, workspace, 2
                                                                         bind = $mainMod, 3, workspace, 3
                                                                         bind = $mainMod, 4, workspace, 4
                                                                         bind = $mainMod, 5, workspace, 5
                                                                         bind = $mainMod, 6, workspace, 6
                                                                         bind = $mainMod, 7, workspace, 7
                                                                         bind = $mainMod, 8, workspace, 8
                                                                         bind = $mainMod, 9, workspace, 9
                                                                         bind = $mainMod, 0, workspace, 10
                                                                         bind = $mainMod, S, workspace, +1
                                                                         bind = $mainMod, D, workspace, -1
                                                                         bind = $mainMod, period, workspace, e+1
                                                                         bind = $mainMod, comma, workspace,e-1
                                                                         bind = $mainMod, Q, workspace,QQ
                                                                         bind = $mainMod, T, workspace,TG
                                                                         bind = $mainMod, M, workspace,Music

                                                                         #-------------------------------#
                                                                         # special workspace(scratchpad) #
                                                                         #-------------------------------# 
                                                                         bind = $mainMod, minus, movetoworkspace,special
                                                                         bind = $mainMod, equal, togglespecialworkspace

                                                                         #----------------------------------#
                                                                         # move window in current workspace #
                                                                         #----------------------------------#
                                                                         bind = $mainMod SHIFT,left ,movewindow, l
                                                                         bind = $mainMod SHIFT,right ,movewindow, r
                                                                         bind = $mainMod SHIFT,up ,movewindow, u
                                                                         bind = $mainMod SHIFT,down ,movewindow, d

                                                                         #---------------------------------------------------------------#
                                                                         # Move active window to a workspace with mainMod + ctrl + [0-9] #
                                                                         #---------------------------------------------------------------#
                                                                         bind = $mainMod SHIFT, 1, movetoworkspace, 1
                                                                         bind = $mainMod SHIFT, 2, movetoworkspace, 2
                                                                         bind = $mainMod SHIFT, 3, movetoworkspace, 3
                                                                         bind = $mainMod SHIFT, 4, movetoworkspace, 4
                                                                         bind = $mainMod SHIFT, 5, movetoworkspace, 5
                                                                         bind = $mainMod SHIFT, 6, movetoworkspace, 6
                                                                         bind = $mainMod SHIFT, 7, movetoworkspace, 7
                                                                         bind = $mainMod SHIFT, 8, movetoworkspace, 8
                                                                         bind = $mainMod SHIFT, 9, movetoworkspace, 9
                                                                         bind = $mainMod SHIFT, 0, movetoworkspace, 10
                                                                         bind = $mainMod SHIFT, left, movetoworkspace, -1
                                                                         bind = $mainMod SHIFT, right, movetoworkspace, +1
                                                                         # same as above, but doesnt switch to the workspace
                                                                         bind = $mainMod CTRL, 1, movetoworkspacesilent, 1
                                                                         bind = $mainMod CTRL, 2, movetoworkspacesilent, 2
                                                                         bind = $mainMod CTRL, 3, movetoworkspacesilent, 3
                                                                         bind = $mainMod CTRL, 4, movetoworkspacesilent, 4
                                                                         bind = $mainMod CTRL, 5, movetoworkspacesilent, 5
                                                                         bind = $mainMod CTRL, 6, movetoworkspacesilent, 6
                                                                         bind = $mainMod CTRL, 7, movetoworkspacesilent, 7
                                                                         bind = $mainMod CTRL, 8, movetoworkspacesilent, 8
                                                                         bind = $mainMod CTRL, 9, movetoworkspacesilent, 9
                                                                         bind = $mainMod CTRL, 0, movetoworkspacesilent, 10
                                                                         # Scroll through existing workspaces with mainMod + scroll
                                                                         bind = CTRL ALT, RIGHT, workspace, e+1
                                                                         bind = CTRL ALT, LEFT, workspace, e-1

                                                                         #-------------------------------------------#
                                                                         # switch between current and last workspace #
                                                                         #-------------------------------------------#
                                                                         binds {
                                                                              workspace_back_and_forth = 1 
                                                                              allow_workspace_cycles = 1
                                                                         }
                                                                         bind=$mainMod,slash,workspace,previous

                                                                         #------------------------#
                                                                         # quickly launch program #
                                                                         #------------------------# 
                                                                         #bind=$mainMod,B,exec,nvidia-offload librewolf
                                                                         bind=CTRL ALT,F,exec,firefox 
                                                                         bind=$mainMod SHIFT,D,exec,kitty  --class="danmufloat" --hold sh -c "export TERM=xterm-256color && bili"
                                                                         bind=CTRL ALT,L,exec,myswaylock
                                                                         #bind=CTRL,,exec,telegram-desktop
                                                                         #bind=$mainMod,Q,exec,nvidia-offload icalingua-plus-plus --enable-features=UseOzonePlatform --ozone-platform=wayland
                                                                         bind=CTRL ALT,P,exec,grimblast --notify --cursor  copysave area ~/Pictures/Screenshot/$(date "+%Y-%m-%d"T"%H:%M:%S").png
                              										   bind=$mainMod,A,exec,grimblast --notify copysave output ~/Pictures/Screenshot/$(date "+%Y-%m-%d"T"%H:%M:%S").png
                                                                         bind=$mainMod,r,exec, pkill rofi || ~/.config/rofi/launcher.sh
                        												   bind=$mainMod,x,exec, bash ~/.config/rofi/powermenu.sh
                        												   #bind=,XF86PowerOff,exec, bash ~/.config/rofi/powermenu.sh
                  													   bind=CTRL ALT,B,exec,bluetooth_headphone
                                                                         bind=$mainMod,e,exec, bash ~/.config/rofi/drun.sh
            															   bind=$mainMod,n,exec, wallpaper_next 
            															   bind=$mainMod,m,exec, wallpaper_prev

                                                                         #-----------------------------------------#
                                                                         # control volume,brightness,media players-#
                                                                         #-----------------------------------------#
                                                                         bind=,XF86AudioRaiseVolume,exec, pamixer -i 5
                                                                         bind=,XF86AudioLowerVolume,exec, pamixer -d 5
                                                                         bind=,XF86AudioMute,exec, pamixer -t
                                                                         bind=,XF86AudioMicMute,exec, pamixer --default-source -t
                                                                         bind=,XF86MonBrightnessUp,exec, light -A 5
                                                                         bind=,XF86MonBrightnessDown, exec, light -U 5
                                                                         bind=,XF86AudioPlay,exec, mpc -q toggle 
                                                                         bind=,XF86AudioNext,exec, mpc -q next 
                                                                         bind=,XF86AudioPrev,exec, mpc -q prev

                                                                         #---------------#
                                                                         # waybar toggle #
                                                                         # --------------#
                                                                         #bind=$mainMod,O,exec,killall -SIGUSR1 .waybar-wrapped

                                                                         #---------------#
                                                                         # resize window #
                                                                         #---------------#
                                                                         bind=ALT,R,submap,resize
                                                                         submap=resize
                                                                         binde=,right,resizeactive,15 0
                                                                         binde=,left,resizeactive,-15 0
                                                                         binde=,up,resizeactive,0 -15
                                                                         binde=,down,resizeactive,0 15
                                                                         binde=,l,resizeactive,15 0
                                                                         binde=,h,resizeactive,-15 0
                                                                         binde=,k,resizeactive,0 -15
                                                                         binde=,j,resizeactive,0 15
                                                                         bind=,escape,submap,reset 
                                                                         submap=reset

                                                                         bind=CTRL SHIFT, left, resizeactive,-15 0
                                                                         bind=CTRL SHIFT, right, resizeactive,15 0
                                                                         bind=CTRL SHIFT, up, resizeactive,0 -15
                                                                         bind=CTRL SHIFT, down, resizeactive,0 15
                                                                         bind=CTRL SHIFT, l, resizeactive, 15 0
                                                                         bind=CTRL SHIFT, h, resizeactive,-15 0
                                                                         bind=CTRL SHIFT, k, resizeactive, 0 -15
                                                                         bind=CTRL SHIFT, j, resizeactive, 0 15

                                                                         bindm = $mainMod, mouse:272, movewindow
                                                                         bindm = $mainMod, mouse:273, resizewindow

                                                                         #-----------------------#
                                                                         # wall(by swww service) #
                                                                         #-----------------------#
                                                                         # exec-once = default_wall 
 
                                                                         #---------------#
                                                                         # windows rules #
                                                                         #---------------#
                                                                         #`hyprctl clients` get class、title...
                                                                         windowrule=float,title:^(Picture-in-Picture)$
                                                                         windowrule=size 960 540,title:^(Picture-in-Picture)$
                                                                         windowrule=move 25%-,title:^(Picture-in-Picture)$
                                                                         windowrule=float,imv
                                                                         windowrule=move 25%-,imv
                                                                         windowrule=size 960 540,imv
                                                                         windowrule=fullscreen,mpv
                                                                         windowrule=float,danmufloat
                                                                         windowrule=move 25%-,danmufloat
                                                                         windowrule=pin,danmufloat
                                                                         windowrule=rounding 5,danmufloat
                                                                         windowrule=size 960 540,danmufloat
                                                                         windowrule=float,termfloat
                                                                         windowrule=move 25%-,termfloat
                                                                         windowrule=size 960 540,termfloat
                                                                         windowrule=rounding 5,termfloat
                                                                         windowrule=float,pcmanfm
                                                                         windowrule=move 25%-,pcmanfm 
                                                                         windowrule=size 960 540,pcmanfm
             
                                                                         windowrulev2 = opacity 90.95 0.95,class:^(org.telegram.desktop)$
                                                            			 windowrulev2=workspace name:S silent, title:Telegram 
                                                                         windowrulev2 = opacity 1.0 1.0,class:^(librewolf)$
                                                                  	     windowrulev2= workspace 3,class:^(firefox)$
                                                                         windowrulev2 = opacity 0.8 0.8,class:^(kitty)$
                                                      				     windowrulev2 = workspace 4,class:^(org.kde.okular)$
                                                      				     windowrulev2 = opacity 0.93 0.93,class:^(org.kde.okular)$
                                                                         windowrulev2 = workspace name:D silent,class:^(transmission-gtk)$
                                                						 windowrulev2 = opacity 0.85 0.85, class:^(transmission-gtk)$
                                                						 windowrulev2 = workspace name:S silent,class:^(discord)$


                                                                         #windowrule=opacity 0.95,title:QQ
                                                                         windowrule=animation slide right,kitty
                                                                         windowrule=workspace name:S silent, title:Discord
                                                                         windowrule=float,ncmpcpp
                                                                         windowrule=move 25%-,ncmpcpp
                                                                         windowrule=size 960 540,ncmpcpp
      

                                                                         #-----------------#
                                                                         #  Dunst Control  #
                                                                         #-----------------#
                                                                          bind=CTRL SHIFT,SPACE,exec, dunstctl close-all
                                                                          bind=CTRL, SPACE,exec, dunstctl close

                                                                         #------------#
                                                                         # auto start #
                                                                         #------------#
             
                                                                         exec-once = launch_waybar &
                                                                         #exec-once = mako &
                                                                         exec-once = border_color &
                                                                         exec-once = nm-applet --indicator &
                                                						 exec-once = transmission-gtk &
                                          							     exec-once = wallpaper_set &
                                    									 exec-once = wl-copy &
                                                                         exec-once = volume_high & 
            															 exec-once = battery_warning &
      																     exec-once = bluetoothctl power off & 


                                                                         #-----------------#
                                                                         # workspace rules #
                                                                         #-----------------#
                                                                         workspace=HDMI-A-1,10

    '';
  };
}
