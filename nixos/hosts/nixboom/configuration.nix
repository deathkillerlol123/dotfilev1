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
    "${mod}/login/login.nix"
    "${mod}/common/"
    "${mod}/sound/"
  ];
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      #systemd-boot.enable = true;
      grub = {
        enable = true;
        devices = ["nodev"];
       	efiSupport = true;
       	useOSProber = true;
       	theme = inputs.nixos-grub-themes.packages.${pkgs.system}.nixos;
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
      };  };
  users.users.nixboom = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [  
    ];  };  
  security = {
    sudo.extraRules = [{
      users = ["nixboom"];
      commands = [{ command = "ALL";
        options = ["NOPASSWD"];
      }];
    }];
    pam.services.swaylock = {};  };  
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
       	};
        Policy = {
       	  AutoEnable = true;
       	};
      };
    };
  };
  xdg.portal = {
   	enable = true;
    config = {
      common = {
      		default = "*";
    		};
   	};  };
  documentation.enable = false;
  programs = {
    zsh = {
      enable = true;
    };
    niri.enable = false;
    mangowc.enable = true;
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      };
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 1d --keep 2";
      flake = "/home/nixboom/dotfiles/nixos/";
      };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
      ];
    };
  };
  nixpkgs.config = {
    allowUnfree = true;  };
  fonts.packages = with pkgs; [
  	nerd-fonts.fira-code
  	nerd-fonts.droid-sans-mono  ];

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