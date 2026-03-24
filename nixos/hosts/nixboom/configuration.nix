{ config, lib, pkgs, inputs, ... }:

let
  mod=../../modules;
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../main.nix    
    "${mod}/environment/"
    "${mod}/login/"
    "${mod}/common/"
    "${mod}/sound/"
  ];
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
        maxGenerations = 5;
        style = {
          wallpapers = lib.filesystem.listFilesRecursive ../../themes/limine_wallpaper;        
          wallpaperStyle = "centered";
          interface = {
            helpHidden = false;
          };
        };
        extraEntries = ''
          /Windows
            protocol: efi
            path: uuid(c5a64789-c514-43f3-97ce-48d094eead3c):/EFI/Microsoft/Boot/bootmgfw.efi
        '';
        extraConfig = ''
          remember_last_entry: yes
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
        "nixboom" = import ./home.nix;
      };
  };
  users.users = {
    nixboom = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [ "wheel" "gamemode" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [  
      ];
    };
  };  
  security = {
    sudo.extraRules = [{
      users = ["nixboom"];
      commands = [{ command = "ALL";
        options = ["NOPASSWD"];
      }];
    }];
    pam.services.swaylock = {}; 
  };  
  xdg.portal = {
   	enable = true;
    config = {
      kde = {
        default = ["kde" "gtk" "gnome"];
        "org.freedesktop.portal.OpenURI" = ["kde"];
      };
   	};  
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      kdePackages.xdg-desktop-portal-kde
    ];
  };
  programs = {
    zsh = {
      enable = false;
    };
    fish = {
      enable = true;
    };
    gamemode.enable = true;
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
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
  fonts.packages = with pkgs; [
  	nerd-fonts.fira-code
  	nerd-fonts.droid-sans-mono
  ];
  environment.systemPackages = with pkgs; [
    #inputs.nix-software-center.packages.${system}.nix-software-center    
    #inputs.matugen.packages.${system}.default
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you 
  # not available with flakes
  #system.copySystemConfiguration = true;

  # Most users should NEVER change this value after the initial install, for any reason,
  system.stateVersion = "25.11";
}