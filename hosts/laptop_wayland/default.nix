{ config, pkgs, user, inputs, lib, ... }:

{
  imports =
    (import ../../modules/hardware) ++
    [
      ./hardware-configuration.nix
      ../../modules/fonts
    ] ++ [
      # ../../../modules/desktop/sway
      ../../modules/desktop/hyprland
    ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  programs.zsh.enable = true;

  users.users.venerable_white = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "video" "audio" ];
    packages = (with pkgs; [
      tdesktop
    ]) ++ (with config.nur.repos;[
      # linyinfeng.icalingua-plus-plus
    ]);
  };
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    bootspec.enable = true;
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 3;
    };
    kernelParams = [
      "quiet"
      "splash"
      "nvidia-drm.modeset=1"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };


  services.xserver = {
    xkb.layout = "us";
    xkb.options = "caps:escape";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";                          # or us/azerty/etc
  };

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services = {
    dbus.packages = [ pkgs.gcr ];
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      audio.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
      socketActivation = true;
      systemWide = true;
      wireplumber.enable = true;
    };
  };

  services = {
    syncthing = {
      enable = true;
      systemService = true;
      user = "venerable_white";
      dataDir = "/home/venerable_white";
      configDir = "/home/venerable_white/.config/syncthing";
      overrideDevices = false; # overrides any devices added or deleted through the WebUI
      overrideFolders = false; # overrides any folders added or deleted through the WebUI
      relay.enable = false;
      settings = {
        devices = {
          "realme" = {
            id = "YVZ3U2X-WPQ75Z5-TDTRWVX-X5H2WIQ-2PB5PMO-QEO72XL-DG26W26-XTVKNQQ";
            addresses = [ "tcp://192.168.0.177:22000" ];
          };
        };
        folders = {
          "Sync" = {
            # Name of folder in Syncthing, also the folder ID
            path = "/home/venerable_white/Sync"; # Which folder to add to Syncthing
            devices = [ "realme" ]; # Which devices to share the folder with
            ignorePerms = false;
          };

          "Music" = {
            # Name of folder in Syncthing, also the folder ID
            path = "/mnt/media_m/Music/Selection"; # Which folder to add to Syncthing
            devices = [ "realme" ]; # Which devices to share the folder with
            ignorePerms = false;
          };

          "Important Files" = {
            # Name of folder in Syncthing, also the folder ID
            path = "/mnt/study/important_files"; # Which folder to add to Syncthing
            devices = [ "realme" ]; # Which devices to share the folder with
            ignorePerms = false;
          };

          "Pictures" = {
            # Name of folder in Syncthing, also the folder ID
            path = "/mnt/media_m/Pictures/pictures"; # Which folder to add to Syncthing
            devices = [ "realme" ]; # Which devices to share the folder with
            ignorePerms = false;
          };

          "camera" = {
            # Name of folder in Syncthing, also the folder ID
            path = "/mnt/media_m/Pictures/camera"; # Which folder to add to Syncthing
            devices = [ "realme" ]; # Which devices to share the folder with
            ignorePerms = false;
          };

          "Research" = {
            # Name of folder in Syncthing, also the folder ID
            path = "/mnt/study/research/sivr/game_theoretic_simulation_of_double_strain_disease"; # Which folder to add to Syncthing
            devices = [ "realme" ]; # Which devices to share the folder with
            ignorePerms = false;
          };



        };
        options = {
          relaysEnabled = false;
          globalAnnounceServer = "";
          globalAnnounceEnabled = false;
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      libnotify
      wl-clipboard
      wlr-randr
      wayland
      wayland-scanner
      wayland-utils
      egl-wayland
      wayland-protocols
      pkgs.xorg.xeyes
      glfw-wayland
      xwayland
      polkit_gnome
      networkmanagerapplet
      wev
      alsa-lib
      alsa-utils
      flac
      pulsemixer
      linux-firmware
      imagemagick
      pkgs.sway-contrib.grimshot
      grim
      syncthing
      conda
      helvum
      gnome.gnome-disk-utility
    ];
  };


  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  security.polkit.enable = true;
  security.sudo = {
    enable = false;
    extraConfig = ''
      ${user} ALL=(ALL) NOPASSWD:ALL
    '';
  };
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass :wheel
    '';
  };

}
