{ config, lib, pkgs, inputs, ... }:
let
  mod=../../modules;
  username="nixboom";
  flake_pos="/home/nixboom/dotfiles/nixos/";
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../main.nix    
    "${mod}/environment/"
    "${mod}/portals"
    "${mod}/login/"
    "${mod}/common/"
    "${mod}/sound/"
    "${mod}/gaming/"
    "${mod}/settings/"
  ];
  services.fwupd.enable = false;  
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      #systemd-boot.enable = true;
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
  users.users.${username}.extraGroups = ["wheel" "gamemode"];
  cleaner = {
    enable = true;
    flake-location = flake_pos;
  };
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs ; };
      users = {
        ${username} = import ./home.nix;
      };
  };
  programs.dconf.enable = true;
  services.suricata.settings.logging.outputs.syslog.enable = true;
#  services.syslog-ng.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  system.stateVersion = "25.11";
}
