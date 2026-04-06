{ config, lib, pkgs, inputs,self, ... }:
let
  mod=../..;
  username="nixboom";
  flake_pos="/home/nixboom/dotfiles/nixos/";
in
{
  flake.nixosConfigurations.myMachine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.myMachinemodule
      self.nixosModulesfonts
    ];
  };
  flake.nixosModules.myMachineModule = {pkgs,...}: {
    imports = [
      /home/nixboom/dotfiles/nixos/modules/hosts/nixboom/hardware-configuration.nix
      inputs.home-manager.nixosModules.default
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
      userName = username;
      shell = "fish";
    };
    users.users.${username}.extraGroups = ["wheel" "gamemode" "uinput"];
    cleaner = {
      enable = true;
      flake-location = flake_pos;
    };
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "hm-backup";
      extraSpecialArgs = { inherit inputs ; };
        users = {
          ${username} = import ./home.nix;
        };
    };
    system.stateVersion = "25.11";
  };
}
