{inputs,self,...}:{
  flake.nixosModules.users = { config, lib, pkgs, inputs,... }:{
    imports = with self.nixosModules; [
      main-user
      nixboom
      doct
    ];
    main-user.users = {
      nixboom = {
        enable = true;
        groups = ["wheel" "gamemode"];
      };
      doct = {
        enable = false;
	groups = ["wheel" "gamemode"];
      };
    };
  };
}
