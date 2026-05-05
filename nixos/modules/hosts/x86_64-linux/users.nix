{inputs,self,...}:
{
  flake.nixosModules.users = { config, lib, pkgs, inputs,... }:{
    imports = with self.nixosModules; [
      main-user
      dragon
    ];
    main-user.users = {
      nixboom = {
        enable = true;
	shell = pkgs.fish;
	groups = ["wheel" "gamemode" "uinput"];
      };
    };
  };
}
    