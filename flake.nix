{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, unstable, home-manager, ... }@inputs: {
    nixosConfigurations.YUV-PC = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/YUV-PC/default.nix

        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import unstable {
                system = prev.system;
                config.allowUnfree = true;
              };
            })
          ];
        }

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.fantomtchi7 = import ./home/fantomtchi7/default.nix;
        }
      ];
    };
  };
}
