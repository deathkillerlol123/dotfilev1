{ config, lib, pkgs, inputs, self, ... }:{
   imports = [
     inputs.home-manager.nixosModules.default
     ./laptop-hardware.nix
     ../main.nix
   ];
   lime = {
     enable = true;
     generations = 3;
     wallpapers = ../../themes/limine_wallpaper;
     params = [ "snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "quiet"];
     windows = {
       enable = true;
       location = "uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi";
     };
   };
   main-user = {
     enable = true;
     userName = "nixboom";
     shell = "fish";
     groups = ["wheel" "gamemode" "uinput"];
     flakelocation = "/home/nixboom/dotfiles/nixos/";
   };
   home-man = {
     enable = true;
     ext = "hm-backupidk";
     home = ./home.nix;
   };
   system.stateVersion = "25.11";
}
