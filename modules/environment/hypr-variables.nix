{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      GTK_THEME = "Dracula";
      GTK_IM_MODULE = "ibus";
      QT_IM_MODULE = "ibus";
      XMODIFIERS = "@im=ibus";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_SCALE_FACTOR = "1";
      MOZ_ENABLE_WAYLAND = "1";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      #GTK-APPLICATION-PREFER-DARK-THEME = 1;
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      #QT_STYLE_OVERRIDE = "Dracula";
      WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
      WLR_NO_HARDWARE_CURSORS = "1"; # if no cursor,uncomment this line  
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
      # GBM_BACKEND = "nvidia-drm";
      CLUTTER_BACKEND = "wayland";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia";
      WLR_RENDERER = "vulkan";
      NIXOS_OZONE_WL = "1";
      # __NV_PRIME_RENDER_OFFLOAD = "1";
      ANIME_DOWNLOAD_FOLDER = "/mnt/media_m/Anime/Airing";
      MUSIC_DOWNLOAD_FOLDER = "/mnt/media_m/Music/Selection";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
      NIXPKGS_ALLOW_UNFREE = 1;
    };
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };
}
