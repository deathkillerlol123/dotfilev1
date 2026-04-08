{ config, lib, pkgs, inputs, self, ... }:{
   imports = [
     inputs.home-manager.nixosModules.default
     ./laptop-hardware.nix
     ../main.nix
   ];
   boot = {
     loader = {
       efi.canTouchEfiVariables = true;
       limine = {
         enable = true;
         maxGenerations = 3;
         style = {
           wallpapers = lib.filesystem.listFilesRecursive ../../themes/limine_wallpaper;        
         };
         extraEntries = ''
           /Windows
             protocol: efi
             path: uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi
         '';
       };
     };
     kernelParams = [ "snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" "quiet"];
     kernelPackages = pkgs.linuxPackages_latest;
     consoleLogLevel = 3;
   };
   main-user = {
     enable = true;
     userName = "nixboom";
     shell = "fish";
     groups = ["wheel" "gamemode"];
     flake-location = "/home/nixboom/dotfiles/nixos/";
   };
   home-man = {
     enable = true;
     ext = "hm-backup";
     home = ./home.nix;
   };
   system.stateVersion = "25.11";
}
