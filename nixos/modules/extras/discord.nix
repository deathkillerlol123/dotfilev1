{config,inputs,lib,pkgs,...}:{
  flake.nixosModules.discord = {config,inputs,lib,pkgs,...}:{
    imports = [ inputs.nixcord.homeModules.nixcord ];
    programs.nixcord = {
      enable = true;
      discord.equicord.enable = true;
    };
  };
}
