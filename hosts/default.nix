{ system, self, nixpkgs, inputs, user, ... }:

let
  pkgs = import nixpkgs {
    inherit system;
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
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user inputs; };
          users.venerable_white = {
            imports = [
              (import ./laptop_wayland/home.nix)
            ];
          };
        };
        nixpkgs = {
          overlays =
            [
             # inputs.picom.overlays.default
            ]
            ++ (import ../overlays);
        };
      }
    ];
  };

}
