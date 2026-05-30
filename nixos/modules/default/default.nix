{inputs,self,...}:{
  flake.nixosModules.default = {config,lib,pkgs,inputs,...}:{
    imports = with self.nixosModules; [
      login
      portals
    ];
  };
}