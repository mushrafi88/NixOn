{
  description = "My Personal NixOS Configuration";
  
  nixConfig = {
    allowUnfree = true;
    extra-substituters = [
      "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://ezkea.cachix.org"
    ];
    extra-trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
  };
  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      nur.url = "github:nix-community/NUR";
      flake-parts.url = "github:hercules-ci/flake-parts";
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      nix-gaming.url = "github:fufexan/nix-gaming";
      flake-root.url = "github:srid/flake-root";
      flake-compat = {
        url = "github:inclyc/flake-compat";
        flake = false;
      };
      firefox-addons = {
        url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      ags.url = "github:Aylur/ags";
    };

  outputs = { self, nixpkgs, flake-parts, ... }@inputs:
    let
      user = "venerable_white";
      domain = "nixon";
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        inputs.flake-root.flakeModule
      ];
      perSystem = { config, inputs, pkgs, system, lib, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlays.default
            ];
          };
        in
        { };

      flake = {
        nixosConfigurations = (
          import ./hosts {
            system = "x86_64-linux";
            inherit nixpkgs self inputs user;
          }
        );
      };
    };
}
