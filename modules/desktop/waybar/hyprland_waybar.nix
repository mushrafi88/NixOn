{ config, lib, pkgs, user, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar
  ];

  nixpkgs.overlays = [
    (final: prev: {
      waybar = prev.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        postPatch = (oldAttrs.postPatch or "") + ''
          sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp'';
      });
    })
  ];

  home-manager.users.venerable_white = {
    # Home-manager waybar config
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
      style = ''
              * {
          font-family: "JetBrainsMono Nerd Font";
          font-size: 10pt;
          min-height: 0;
          font-weight: bold;
          border-radius: 0px;
          transition-property: background-color;
          transition-duration: 0.5s;
        }
        @keyframes blink_red {
          to {
            background-color: rgb(242, 143, 173);
            color: rgb(26, 24, 38);
          }
        }
        .warning,
        .critical,
        .urgent {
          animation-name: blink_red;
          animation-duration: 1s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }
        window#waybar {
          background-color: transparent;
          background: rgba(21, 18, 27, 0);
          color: #f6f7fc;
        }
        window > box {
          margin-left: 0px;
          margin-right: 0px;
          margin-top: 0px;
          margin-bottom: 0px;
          background-color: rgba(30, 30, 46, 0);
        }
        #workspaces {
          padding-left: 0px;
          padding-right: 4px;
          margin: 7px; /* This will create space around the component */
          border-radius: 8px;
        }
        #workspaces button {
          padding-top: 4px;
          padding-bottom: 4px;
          padding-left: 6px;
          padding-right: 6px;
          background-color: rgba(248, 189, 150, 0.5);
          color: rgb(26, 24, 38);

          /* Set this to the same value as width */
          border-radius: 50%; /* Makes the element round */
        }
        #workspaces button.active {
          background-color: rgba(181, 232, 224, 0.5);
          color: rgb(26, 24, 38);
        }
        #workspaces button.urgent {
          color: rgb(26, 24, 38);
        }
        #workspaces button:hover {
          background-color: rgb(248, 189, 150);
          color: rgb(26, 24, 38);
        }
        tooltip {
          background: rgb(48, 45, 65);
        }
        tooltip label {
          color: rgb(217, 224, 238);
        }
        #custom-launcher {
          background-color: rgba(10, 10, 10, 0.5);
          font-size: 11px;
          padding-left: 8px;
          padding-right: 6px;
          color: #7ebae4;
          border-radius: 100%;
        }
        #mode,
        #clock,
        #memory,
        #temperature,
        #cpu,
        #mpd,
        #custom-wall,
        #temperature,
        #backlight,
        #pulseaudio,
        #network,
        #battery,
        #custom-powermenu,
        #custom-cava-internal {
          padding-left: 10px;
          padding-right: 10px;
          margin: 7px; /* This will create space around the component */
          border-radius: 8px;
        }
        /* #mode { */
        /* 	margin-left: 10px; */
        /* 	background-color: rgb(248, 189, 150); */
        /*     color: rgb(26, 24, 38); */
        /* } */
        #memory {
          background-color: rgba(10, 10, 10, 0.5);
          color: rgb(181, 232, 224);
        }
        #cpu {
          background-color: rgba(10, 10, 10, 0.5);
          color: rgb(245, 194, 231);
        }
        #clock {
          background-color: rgba(10, 10, 10, 0.5);

          color: #abe9b3;
        }
        /* #idle_inhibitor {
                                 color: rgb(221, 182, 242);
                               }*/
        #custom-wall {
          color: rgb(221, 182, 242);
        }
        #temperature {
          color: rgb(150, 205, 251);
        }
        #backlight {
          background-color: rgba(10, 10, 10, 0.5);

          color: rgb(248, 189, 150);
        }
        #pulseaudio {
          background-color: rgba(10, 10, 10, 0.5);

          color: rgb(245, 224, 220);
        }
        #network {
          background-color: rgba(10, 10, 10, 0.5);

          color: #abe9b3;
        }

        #network.disconnected {
          background-color: rgba(10, 10, 10, 0.5);

          color: rgb(255, 255, 255);
        }
        #battery.charging,
        #battery.full,
        #battery.discharging {
          background-color: rgba(10, 10, 10, 0.5);

          color: rgb(250, 227, 176);
        }
        #battery.critical:not(.charging) {
          background-color: rgba(10, 10, 10, 0.5);

          color: rgb(242, 143, 173);
        }
        #custom-powermenu {
          background-color: rgba(10, 10, 10, 0.5);

          color: rgb(242, 143, 173);
        }
        #tray {
          background-color: rgba(10, 10, 10, 0);
          padding-right: 3px;
          padding-left: 3px;
          border-radius: 8px;
        }
        #mpd.paused {
          background-color: rgba(10, 10, 10, 0.5);

          color: #414868;
          font-style: italic;
        }
        #mpd.stopped {
          background-color: rgba(10, 10, 10, 0.5);

          background: transparent;
        }
        #mpd {
          background-color: rgba(10, 10, 10, 0.5);

          color: #c0caf5;
        }
        #custom-cava-internal {
          background-color: rgba(10, 10, 10, 0.5);

          font-family: "Hack Nerd Font";
        }
                      
      '';
      settings = [{
        "layer" = "top";
        "position" = "top";
        modules-left = [
          # "custom/launcher"
          "wlr/workspaces"
          #"idle_inhibitor"
          #"custom/wall"
          "mpd"
          "custom/cava-internal"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          # "pulseaudio"
          # "backlight"
          "memory"
          "cpu"
          "network"
          "battery"
          #"custom/powermenu"
          "tray"
        ];
        "custom/launcher" = {
          "format" = " ";
          "on-click" = "pkill rofi || ~/.config/rofi/launcher.sh";
          "tooltip" = false;
        };
        "custom/wall" = {
          "on-click" = "wallpaper_random";
          "on-click-middle" = "default_wall";
          "on-click-right" = "killall dynamic_wallpaper || dynamic_wallpaper &";
          "format" = " 󰠖 ";
          "tooltip" = false;
        };
        "custom/cava-internal" = {
          "exec" = "sleep 1s && cava-internal";
          "tooltip" = false;
        };
        "wlr/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
          "tooltip" = false;
        };
        "backlight" = {
          "device" = "intel_backlight";
          "on-scroll-up" = "light -A 5";
          "on-scroll-down" = "light -U 5";
          "format" = "{icon} {percent}%";
          "format-icons" = [ "󰃝" "󰃞" "󰃟" "󰃠" ];
        };
        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-muted" = "󰖁 Muted";
          "format-icons" = {
            "default" = [ "" "" "" ];
          };
          "on-click" = "pamixer -t";
          "tooltip" = false;
        };
        "battery" = {
          "interval" = 10;
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon} {capacity}%";
          "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          "format-full" = "{icon} {capacity}%";
          "format-charging" = "󰂄 {capacity}%";
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 1;
          "format" = "{:%I:%M %p  %A %b %d}";
          "tooltip" = true;
          /* "tooltip-format"= "{=%A; %d %B %Y}\n<tt>{calendar}</tt>" */
          "tooltip-format" = "<tt>{calendar}</tt>";
        };
        "memory" = {
          "interval" = 1;
          "format" = "󰍛 {percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "cpu" = {
          "interval" = 1;
          "format" = "󰻠 {usage}%";
        };
        "mpd" = {
          "max-length" = 25;
          "format" = "<span foreground='#bb9af7'></span> {title}";
          "format-paused" = " {title}";
          "format-stopped" = "<span foreground='#bb9af7'></span>";
          "format-disconnected" = "";
          "on-click" = "mpc --quiet toggle";
          "on-click-right" = "mpc update; mpc ls | mpc add";
          "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp ";
          "on-scroll-up" = "mpc --quiet prev";
          "on-scroll-down" = "mpc --quiet next";
          "smooth-scrolling-threshold" = 5;
          "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
        };
        "network" = {
          "format-disconnected" = "󰯡 Disconnected";
          "format-ethernet" = "↑ {bandwidthUpBytes} ↓ {bandwidthDownBytes} 󰀂  󰖩  {ifname} ({ipaddr})";
          "format-linked" = "󰖪 {essid} (No IP)";
          "format-wifi" = "↑ {bandwidthUpBytes} ↓ {bandwidthDownBytes}";
          "interval" = 1;
          "tooltip" = true;
        };
        "temperature" = {
          # "hwmon-path"= "${env:HWMON_PATH}";
          #"critical-threshold"= 80;
          "tooltip" = false;
          "format" = " {temperatureC}°C";
        };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "pkill rofi || ~/.config/rofi/powermenu.sh";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 12;
          "spacing" = 5;
        };
      }];
    };
  };
}
