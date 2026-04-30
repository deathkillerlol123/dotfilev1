#86-64-linux
{inputs,self,...}:
let
  user = "nixboom";
in
{
  flake.nixosModules.dragon = { config, lib, pkgs, inputs,... }:{
    imports = with self.nixosModules; [
      inputs.home-manager.nixosModules.home-manager    
      main      
      dragboomware
    ];
    lime = {
      enable = true;
      wallpapers = "${self.outPath}/themes/limine_wallpaper";      
      params = [ "snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "quiet"];
      windows = {
        enable = true;
        location = "uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi";
      };
    };
    main-user = {
      enable = true;
      userName = user;
      flakelocation = self.outPath;      
      groups = ["wheel" "gamemode" "uinput"];
    };
    flatpak = {
      enable = true;
      apps = ["org.vinegarhq.Sober" "ch.openboard.OpenBoard" ];
    };
    home-man = {
      enable = true;
      ext = "hm-backup";
      home = "${self.outPath}/modules/hosts/86-64-linux/${user}/dragonfly/_homedragboom.nix";
    };
    nix.settings.trusted-users = [ "root" user ];
    system.stateVersion = "25.11";
  };
}