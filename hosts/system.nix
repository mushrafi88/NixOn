{ config, pkgs, lib, inputs, user, ... }:

{
  nixpkgs.system = "x86_64-linux";

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "nixon"; # Define your hostname.
    networkmanager.enable = true;
  };
  time.timeZone = "Asia/Dhaka";

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
      neovim
      wget
      neofetch
      eza
      gcc
      clang
      zig
      p7zip
      atool
      unzip
      ffmpeg
      ffmpegthumbnailer
      glib
      xdg-utils
      pciutils
      gdb
      killall
      zip
      rar
      broot
      pandoc
      bat
      mediainfo
      unrar
      socat
      acpi
      perl
      inotify-tools
      python311
      python311Packages.pip
    ];
  };
  services.dbus.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true; # Optimise syslinks
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
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
    stateVersion = "23.11";
  };
}
