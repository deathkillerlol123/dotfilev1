{inputs,self,...}:{
  flake.nixosModules.users = { config, lib, pkgs, inputs,... }:{
    imports = with self.nixosModules; [
      main-user
      home-man
      nixboom
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
    home-man = {
      enable = true;
      users = [
      ];
    };
  };
}
