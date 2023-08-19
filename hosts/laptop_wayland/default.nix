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
    pinentryFlavor = "gnome3";
  };
  programs.zsh.enable = true;
  users.users.venerable_white = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "video" "audio" ];
    packages = (with pkgs; [
      tdesktop
      thunderbird
    ]) ++ (with config.nur.repos;[
      # linyinfeng.icalingua-plus-plus
    ]);
  };
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    bootspec.enable = true;
    loader = {
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
      efi = {
        #canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
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

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ m17n ];
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
      pkgs.qt6.qtwayland
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
      openbangla-keyboard
      syncthing
    ];
  };

  services.xserver = {
    xkbOptions = "caps:escape";
  };
  console.useXkbConfig = true;

  services = {
    dbus.packages = [ pkgs.gcr ];
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
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
      settings = {
        devices = {
          "realme" = { id = "5O4CEWW-OZFK5XF-PCQL2U4-PMBILKU-PWYI6HD-YX75SLZ-ANUWTMW-2AGQGAH"; };
        };
        folders = {
          "Documents" = {
            # Name of folder in Syncthing, also the folder ID
            path = "/home/venerable_white/Documents"; # Which folder to add to Syncthing
            devices = [ "realme" ]; # Which devices to share the folder with
            ignorePerms = false;
          };
          "Example" = {
            path = "/home/venerable_white/Templates";
            devices = [ "realme" ];
            ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          };
        };
      };
    };
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
