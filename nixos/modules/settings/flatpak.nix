{inputs,self,...}:{
  flake.nixosModules.flatpak = {inputs,lib,config,pkgs,...}:{
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];
  
    options.flat.apps = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of Flatpak app IDs to install";
    };
  
    config = {
      services.flatpak = {
        enable = true;
  
        packages = [
          { appId = "com.brave.Browser"; origin = "flathub"; }
        ] ++ map (appId: { inherit appId; origin = "flathub"; }) config.flat.apps;
      };
    };
  };
}