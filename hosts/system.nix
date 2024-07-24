{ config, pkgs, lib, inputs, user, ... }:

{
  nixpkgs.system = "x86_64-linux";
  nixpkgs.config.allowUnfree = true; 

  networking = {
    hostName = "nixon"; # Define your hostname.
    networkmanager.enable = true;
  };
  time.timeZone = "Asia/Dhaka";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "all" ]; 
  security.rtkit.enable = true;
  services = {
    openssh = {
      enable = false;
    };
    flatpak = {
      enable = true;
    };
  };

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      git
      git-lfs
      neovim
      wget
      neofetch
      eza
      gcc
      clang
      cmake
      zig
      atool
      p7zip
      unzip
      rar 
      unrar
      zip
      ffmpeg
      ffmpegthumbnailer
      glib
      xdg-utils
      pciutils
      gdb
      killall
      broot
      pandoc
      bat
      mediainfo
      socat
      acpi
      inotify-tools
      python311
      python311Packages.pip
      glibcLocales
      aria2
      bun #ags 
      brightnessctl #ags  
      sass #ags 
      matugen #ags
      cloudflare-warp # warp 
    ];
  };
  services.dbus.enable = true;
   
  systemd.packages = [ pkgs.cloudflare-warp ]; 
  systemd.targets.multi-user.wants = [ "warp-svc.service" ]; 

  nix = {
    settings = {
      auto-optimise-store = true; # Optimise syslinks
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  system = {
    autoUpgrade = {
      enable = false;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "24.05";
  };
}
