# Preparing for NixOS Installation

Check the configuration.nix file and make sure that there is a `/boot/efi` directory if the
`efiSysMount` option is set to `/boot`

# Adding unstable channel for nix

First you need to add unstable to your nix-channels:

```
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
```

Then we need to fetch the actual channel

```
sudo nix-channel --update
```

Furthermore we have to update the cache of nix search:

```
sudo nix search -u
```

remove stable version if needed, check using

```
sudo nix-channel --list
```

Update all of your packages in the home-manager or the current user environment.

```
nix-env -u '*'
home-manager switch
```

To update system root packages

```
sudo nixos-rebuild switch
```

# Making NixOS Rolling

To make your NixOS installation a rolling release, you can either download a rolling release image or follow these steps after a fresh install:

1. Add the NixOS unstable channel:

```
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos

```

2. Upgrade your system:

```
sudo nixos-rebuild switch --upgrade

```

to update your system, first update the channel packages:

```
sudo nix-channel --update

```

Then, update all packages:

```
sudo nixos-rebuild switch

```

Check the NixOS version

```
nixos-version
```

# Adding Home Manager

Home Manager is a tool for managing user-specific configuration. To add the latest version of Home Manager, follow these steps:

1. Add the Home Manager channel:

```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
```

There are two ways to install Home Manager: as a Nix module or as a standalone package.

## Home Manager as a Nix Module

To install Home Manager as a Nix module, follow these steps:

1. Add `<home-manager/nixos>` under imports in configuration.nix.

2. Set `users.users.<name>.isNormalUser = true;`

3. Add `home-manager.users.<name> = { pkgs, ... }:` to configuration.nix as shown below:

```
home-manager.users.<name> = { pkgs, ... }: {
  home.packages = [ pkgs.atool pkgs.httpie ];
  home.stateVersion = "22.11";
};
```

If you want to manage Home Manager packages in a separate file, you can create a `/etc/nixos/home.nix` and add the following lines:

```
{ config, pkgs, ... }:

{
  home.username = "<username>";
  home.homeDirectory = "/home/<username>";
  home.packages = [ pkgs.atool pkgs.httpie ];
  home.stateVersion = "22.11";
}
```

Then, reference this file in `configuration.nix` with the following command:

```
home-manager = {
  useGlobalPkgs = true;
  useUserPackages = true;
  users.<name> = import ./home.nix;
};

```

## Home Manager as a Standalone Package

To install Home Manager as a standalone package, follow these steps:

1. Add the installation channel

```
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update
```

2. Remove any reference to the Home Manager module in the `configuration.nix` file.
3. Install Home Manager

```
nix-shell '<home-manager>' -A install
```

The configuration will be in the `$HOME/.config/nixpkgs/home.nix`

# After Home Manager is installed:

## Config

1. NixOS module: `/etc/nixos`
2. Standalone: `~/.config/nixpkgs/`

## Update nix channel:

1. NixOS: `sudo nix-channel --update`
2. Home manager: `nix-channel --update`

## Apply home manager changes command:

1. NixOS module: `sudo nixos-rebuild switch`
2. Standalone: `home-manager switch`

# Configuring the configs within the `home.nix`

Some configs like zsh need extra enabling in the `configuration.nix`
There are two ways of writing a config

## Direct method in `home.nix`

```
{ config, pkgs, ... }:

{
  home.username = "<username>";
  home.homeDirectory = "/home/<username>";

  home.packages = [ pkgs.atool pkgs.httpie ];
  #config file
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "docker-compose" "docker" ];
      theme = "dst";
    };
    initExtra = ''
      bindkey '^f' autosuggest-accept
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.stateVersion = "22.11";
}
```

## Indirect Method

Keep in mind that some packages are not installed but just should be enabled (zsh in this case more on the configuration.nix file)

To offload the configs first move the configs to a file like this `.config/nixpkgs/apps/zsh.nix` like below

```
{  # keep in mind the squirly brackets
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "docker-compose" "docker" ];
      theme = "dst";
    };
    initExtra = ''
      bindkey '^f' autosuggest-accept
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}

```

Then reference it in the home.nix

```
{ config, pkgs, ... }:

{
  home.username = "<username>";
  home.homeDirectory = "/home/<username>";

  home.packages = [ pkgs.atool pkgs.httpie ];
  #config file
  imports = [
    ./apps/zsh.nix
    ./apps/micro.nix ];
  home.stateVersion = "22.11";
}

```

Keep in mind that the `apps/config.nix` or home-manager configs in general will rewrite the original setting or config files in the `.config` So if error occurs just delete thoseconfig files.

# Cleaning Up Older Files

To clean up older files, you can use the following commands:

1. To list out generations

```
nix-env --list-generations
```

if for some reason it does not work use this command.

```
nix-env -p /nix/var/nix/profiles --list-generations
```

2. To delete a particular generation

```
nix-env -p /nix/var/nix/profiles  --delete-generations 1 2 3
```

3. It is recommeneded to sometimes run as sudo to collect additional garbage

```
sudo nix-collect-garbage -d
```

The above will delete all system garbages. To remove home-manager garbage use the command without root

```
nix-collect-garbage -d
```

4. To remove deleted generations entry from boot

```
sudo nixos-rebuild switch
```

if you are using flakes then

```
sudo nixos-rebuild switch --flakes .#laptop
```

To update Home-Manager

```
sudo nixos-rebuild switch --flake /home/manager/venerable_white/NixOn#nixon
```

Reference

1. `https://tech.aufomm.com/my-nixos-journey-home-manager/`
