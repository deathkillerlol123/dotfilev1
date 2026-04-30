{inputs,self,...}:
{
  flake.nixosConfigurations.nixbtw = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules =
    [
      inputs.home-manager.nixosModules.home-manager
    ]++
    (with self.nixosModules; [
      main
      dragboom
      dragboomware
    ]);    
  };
}