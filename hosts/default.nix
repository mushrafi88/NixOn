{ system, self, nixpkgs, inputs, user, ... }:

let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true; # Allow proprietary software
  };

  lib = nixpkgs.lib;
in
{
  nixon = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      ./laptop_wayland
    ] ++ [
      ./system.nix
    ] ++ [
      inputs.nur.nixosModules.nur
      inputs.hyprland.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user; };
          users.venerable_white = {
            imports = [
              (import ./laptop_wayland/home.nix)
            ] ++ [
              inputs.hyprland.homeManagerModules.default
            ];
          };
        };
        nixpkgs = {
          overlays =
            [
              inputs.picom.overlays.default
            ];
        };
      }
    ];
  };

}
