# NixOn: Your NixOS Flake-Based Installation

Welcome to my nixos repository. 

## Introduction

NixOS is a Linux distribution built on top of the Nix package manager. It features a declarative configuration model and makes system configurations reproducible, ensuring that installations are identical across different environments. The introduction of Nix Flakes has further enhanced this model by improving reproducibility and making it easier to manage Nix environments across multiple projects.

NixOn is designed to provide a streamlined setup process for NixOS using flakes, catering to both newcomers and seasoned Nix users. Whether you're setting up a personal workstation, a server, or a development environment, NixOn offers a solid foundation that you can customize to your needs.

## Features

- **Reproducible Builds**: Ensure your system configuration is consistent across installations.
- **Declarative Configuration**: Define your entire system configuration in a single, version-controlled file.
- **Rollbacks**: Easily revert to previous configurations thanks to Nix's atomic upgrades and rollbacks.
- **Customizable**: Tailor your NixOS setup to your preferences with customizable flakes.

## Prerequisites

Before you begin with NixOn, ensure you have:

- A compatible system running NixOS
- Basic familiarity with Nix and the command line
- Git installed to clone the repository

## Installation Instructions

1. **Prepare Your System**: Ensure Nix is installed on your system. If you're new to Nix, follow the official [Nix installation guide](https://nixos.org/download.html).
```bash
nix-shell -p git vim 
```

2. **Clone the Repository**: Clone this repository to your local machine using Git:

   ```bash
   git clone https://github.com/mushrafi88/NixOn.git
   cd NixOn
   ```
3. **Setting up disks**: Properly link the disk addresses to the flake 
```bash 
nixos-generate-config --show-hardware-config
vim NixOn/hosts/laptop_wayland/hardware-configuration.nix 
```
4. **Setting up Channels**: update the nix-channels to unstable 
```bash
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
sudo nix-channel update 
```
5. **Applying the Configuration**: Use the `nixos-rebuild` command to apply the flake configuration to your system:

   ```bash
   NIX_CONFIG="experimental-features = nix-command flakes"
   sudo nixos-rebuild switch --flake .#nixon
   ```

   Replace `#` with the specific configuration target from your flake, if applicable.

## Usage

After installation, your system will be configured according to the specifications defined in the flake. To modify your system configuration:

1. Edit the flake.nix or other relevant configuration files in the repository.
2. Rebuild your system configuration using the `nixos-rebuild switch --flake .#` command to apply changes.


