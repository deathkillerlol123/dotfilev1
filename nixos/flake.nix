{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
              inputs.stylix.nixosModules.stylix
    	      ];
	  };         
    };
  };
}