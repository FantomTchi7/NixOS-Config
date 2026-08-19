{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      nix-cachyos-kernel,
      ...
    }:
    {
      nixosConfigurations.YUV-PC = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./configuration.nix

          nixos-hardware.nixosModules.gigabyte-b550
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-cpu-amd-zenpower

          {
            nixpkgs.overlays = [
              nix-cachyos-kernel.overlays.pinned
            ];
          }
        ];
      };
    };
}
