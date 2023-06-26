{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
	self,
	nixpkgs,
	home-manager,
	...
  } @ inputs: {

	homeConfigurations.derek = home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          username = "derek"; 
          homeDirectory = "/home/derek";
	  configuration = ./home.nix;
        };
	devShells.x86_64-linux.default = let
		home-manager-bin = home-manager.packages.x86_64-linux.default;

	in
		nixpkgs.legacyPackages.x86_64-linux.mkShell {
			packages = [ home-manager-bin ];
		};
  };
}
