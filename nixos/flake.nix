{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
    };
    #matugen.url = "github:/InioX/Matugen";
    home-manager = {
    	url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations = {
      	  nixbtw = nixpkgs.lib.nixosSystem {
      	    system = "x86_64-linux";
      	    specialArgs = {inherit inputs;};
      	    modules = [ 
      	      ./hosts/nixboom/configuration.nix
      	      inputs.home-manager.nixosModules.default
             grub2-themes.nixosModules.default
    	      ];  
         };         
   	  };
   	};
}