{ config, lib, pkgs, inputs, ... }:
let
  mod=../../modules;
  username="nixboom";
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
    "${mod}/flatpak/"
    "${mod}/gaming/"
    "${mod}/user-setup/main-user.nix"
  ];
  services.fwupd.enable = false;  
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      #systemd-boot.enable = true;
      grub = {
        enable = false;
        devices = ["nodev"];
       	efiSupport = true;
       	useOSProber = true;
       	theme = inputs.nixos-grub-themes.packages.${pkgs.system}.nixos;
      };
      limine = {
        enable = true;
        maxGenerations = 3;
        style = {
          wallpapers = lib.filesystem.listFilesRecursive ../../themes/limine_wallpaper;        
          wallpaperStyle = "stretched";
          interface = {
            helpHidden = false;
          };
        };
        extraEntries = ''
          /Windows
            protocol: efi
            path: uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi
        '';

      };
    };
    kernelParams = [ "snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1"];
    kernelPackages = pkgs.linuxPackages_latest;
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
  main-user = {
    enable = true;
    userName = username;
    .shell = "fish";
  };
  users.users.${username}.extraGroups = ["wheel" "gamemode"];
  programs = {
    fish = {
      enable = true;
    };
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep 3";
      flake = "/home/nixboom/dotfiles/nixos/";
      };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
      ];
    };
  };
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm-yaml";
  };
  fonts.packages = with pkgs; [
  	nerd-fonts.fira-code
  	nerd-fonts.droid-sans-mono
  ];
  environment.systemPackages = with pkgs; [
    #inputs.nix-software-center.packages.${system}.nix-software-center    
    #inputs.matugen.packages.${system}.default
  ];
  # Most users should NEVER change this value after the initial install, for any reason,
  system.stateVersion = "25.11";
}
