{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
    #matugen.url = "github:/InioX/Matugen";
    home-manager = {
    	url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, stylix, ... }@inputs:
    {
      nixosConfigurations = {
      	  nixbtw = nixpkgs.lib.nixosSystem {
      	    system = "x86_64-linux";
      	    specialArgs = {inherit inputs;};
      	    modules = [ 
      	      ./hosts/nixboom/configuration.nix
      	      inputs.home-manager.nixosModules.default
              stylix.nixosModules.stylix
    	      ];  
         };         
   	  };
   	};
}