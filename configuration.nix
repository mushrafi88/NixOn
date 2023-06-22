{ config, user, inputs, lib, self, config, pkgs, ... }:

{

imports = [
  ./hardware-configuration.nix
];

time.timeZone = "Asia/Dhaka";

i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {                 # Extra locale settings that need to be overwritten
      #LC_TIME = "_BE.UTF-8";
      #LC_MONETARY = "nl_BE.UTF-8";
    };
  };


# You can remove font and packages line to have default font kernel chooses.
 console = {
    font = "Lat2-Terminus16";
    keyMap = "us";                          # or us/azerty/etc
  };

environment = {
  # set channels (backwards compatibility)
  etc = {
    "nix/flake-channels/nixpkgs".source = inputs.nixpkgs;
    "nix/flake-channels/home-manager".source = inputs.home-manager;
  };
};

# As name implies, allows Unfree packages. You can enable in case you wanna install non-free tools (eg: some fonts lol)
nixpkgs = {
  config = {
    # keep a check and remove it asap
    permittedInsecurePackages = [
      "openssl-1.1.1u"
    ];
    allowUnfree = true;
    allowBroken = false;
  };
};

# Collect garbage and delete generation every 6 day. Will help to get some storage space.
# Better to atleast keep it for few days, as you do major update (unstable), if something breaks you can roll back.
nix = {
  gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 6d";
  };
  # pin the registry to avoid downloading and evaling a new nixpkgs version every time
  registry = lib.mapAttrs (_: value: { flake = value; }) inputs;  

  # This will additionally add your inputs to the system's legacy channels  
  # Making legacy nix commands consistent as well, awesome!  
  nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;  extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
 

  # substituters are cachix domain, where some package binaries are available (eg : Hyprland & Emacs 30)
  # NOTE : You should do a simple rebuild with these substituters line first,
  # and then install packages from there, as a rebuild will register these cachix into /etc/nix/nix.conf file.
  # If you continue without a rebuild, Emacs will start compiling.
  # So rebuild and make sure you see these substituters in /etc/nix/nix.conf and then add packages.
  settings = {
    auto-optimise-store = true;
    builders-use-substitutes = true;
    trusted-users = ["root" "@wheel"];
    max-jobs = "auto";
    # use binary cache, its not gentoo
    substituters = [
      "https://cache.nixos.org"
      # "https://nix-community.cachix.org"
    ];
    # Keys for the sustituters cachix
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
};
system.autoUpgrade.enable = false;
system.stateVersion = "23.05"; # DONT TOUCH THIS (See about state version on nixos manual)

boot = {
  # Uses bleeding edge latest kernel.
  kernelPackages = pkgs.linuxPackages_latest;
  loader = {
    # FIXME change first line if you want to use Grub
    efi = {
            canTouchEfiVariables = true;
    };
    grub = {
            enable = true;
            devices = ["nodev"];
            efiSupport = true;
            useOSProber = true;
            };
    timeout = 5;
  };

  supportedFilesystems = [ "ntfs" ];
  #tmp.cleanOnBoot = true;
};

networking = {
  hostName = "nixon";
  # dns
  networkmanager = {
    enable = true;
    unmanaged = ["docker0" "rndis0"];
    #wifi.macAddress = "random";
  };

firewall.enable = false;
};

# Avoid slow boot time
#systemd.services.NetworkManager-wait-online.enable = false;

security.rtkit.enable = true;
security.polkit.enable = true;

services = {
  dbus = {
    packages = with pkgs; 
    [
    dconf 
    udisks2
    gcr
    ];
    enable = true;
  };
  # udev.packages = with pkgs; [gnome.gnome-settings-daemon];
  # To mount drives with udiskctl command
  udisks2.enable = true;
  # tlp.enable = true;     # TLP and auto-cpufreq for power management
  #auto-cpufreq.enable = true;
  # For Laptop, make lid close and power buttom click to suspend
  logind = {
    lidSwitch = "suspend";
    extraConfig = ''
  HandlePowerKey = suspend
  '';
  };
  atd.enable = true;
  fstrim.enable = true;
  # See if you want bluetooth setup
  blueman.enable = true;
  gvfs.enable = true;   # For android file transfer via usb, or better check on KDE connect
  # Depends on you if you want login manager or prefer entering password manually
  #getty.autologinUser = "i" ;
  # Pipewire setup, just these lines enought to make sane default for it
  pipewire = {
    enable = true;
    alsa = {
      enable = true;
    };
    wireplumber.enable = true;
    pulse.enable = true;
  };

  flatpak.enable = true;
};

systemd.services = {
  # For wayland users
  seatd = {
    enable = true;
    description = "Seat management daemon";
    script = "${pkgs.seatd}/bin/seatd -g wheel";
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = "3";
    };
    wantedBy = ["multi-user.target"];
  };
};

environment.systemPackages = with pkgs; [
  gitFull
  neovim 
  helix
  librewolf 
  kitty
  pciutils
  usbutils
  lf 
  htop
];

# Add other overlays here
# nixpkgs.overlays = with inputs; [emacs-overlay.overlay];

hardware = {
  opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
      vaapiIntel
    ];
  };
};

fonts = {
  fonts = with pkgs; [
    noto-fonts unifont
    symbola noto-fonts-emoji maple-mono comic-mono
    (nerdfonts.override {fonts = [ "JetBrainsMono" ];})
  ];

  enableDefaultFonts = false;

  # this fixes emoji stuff
  fontconfig = {
    defaultFonts = {
      monospace = [
        "ComicCodeLigatures Nerd Font"
        "JetBrainsMono Nerd Font"
        "Noto Color Emoji"
      ];
      sansSerif = [ "Noto Sans" "JetBrainsMono Nerd Font" "Unifont"];
      serif = [ "Noto Sans" "JetBrainsMono Nerd Font" "ComicCodeLigatures Nerd Font" "Unifont" ];
      emoji = [ "Noto Color Emoji" "ComicCodeLigatures Nerd Font" "Symbola" "Unifont" ];
    };
  };
};

environment = {
  variables = {
    TERMINAL = "kitty";
    NIXOS_OZONE_WL = "1";
    EDITOR = "nvim";
    BROWSER = "librewolf";
    MOZ_ENABLE_WAYLAND = "1";
  };
};

users.users.venerable_white = {
        isNormalUser = true;
        extraGroups = [
                "wheel"
                "gitea" 
                "docker"
                "systemd-journal"
                "audio"
                "plugdev"
                "wireshark"
                "video"
                "input"
                "lp"
                "networkmanager"
                "power"
                "nix"
                 ];
          # Use fish if you prefer it
            shell = pkgs.zsh;
         # Or else login to root (which you will create while rebuilding) and run passwd USERNAME 
        # initialPassword = "changeme";
        };
programs.zsh.enable = true;

}
