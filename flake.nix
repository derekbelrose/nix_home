{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      defaultPackage.${system} = home-manager.defaultPackage.${system};
      homeConfigurations.derek = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;

	pkkgs = nixpkgs.legacyPackages.${system};
	modules = [
	  ./home.nix
	];
      };
    };
}

