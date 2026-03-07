{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
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
	theme = inputs.nixos-grub-themes.packages.${pkgs.system}.hyperfluent;
      };
    };
    kernelParams = [ "snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" ];
  };

  services = {
    displayManager = {
      sddm = {
        enable = false;
       	wayland.enable = true;
      };
      gdm = {
        enable = true;
        wayland = true;
      };
    };
    xserver = {
      enable = true;
      displayManager.lightdm.enable = false;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    desktopManager.gnome.enable = true;
    flatpak.enable = true;
    libinput.enable = true;
  };
  networking = {
    hostName = "nixbtw";
    networkmanager.enable = true;
  };
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
  	};
  };

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    optimise = {
      automatic = true;
      dates = ["20:00"];
    };
  };

  time.timeZone = "Europe/London";

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs ; };
      users = {
        "nixboom" = import ./home.nix;
      };
  };

  users.users.nixboom = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      ];
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
  documentation.enable = false;
  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = false;
    };
  };
  programs = {
    zsh.enable = true;
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
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/nixboom/dotfiles/nixos/";
      };
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
  environment.systemPackages = with pkgs; [
    gdm
    efibootmgr
    
 		xdg-desktop-portal-hyprland
		xdg-desktop-portal-gtk
    mangohud
    protonup-qt
    heroic
    nix-search-cli
    brightnessctl    
    blueberry
    wlr-randr
    borgbackup
    wdisplays   
    git
    gh

    swaynotificationcenter
    swaybg
    swaylock
    wlogout
    nautilus  
    rofi
    waybar
    playerctl
    alsa-utils
    pavucontrol
   
    firefox-devedition
    whatsapp-electron
    discord-ptb

    kitty
    starship
    zsh
    bash
    zoxide
    neovim
    zed-editor
    zellij
    copyq
    grim
    slurp
    wl-clipboard
    swappy
 
    bat
    eza
    btop
    cmatrix
    neofetch
    ranger
    stow
    swww
    pywal
    kdePackages.gwenview  
    ntfs3g


    mangowc
    glibc
    wayland
    wayland-protocols
    libinput
    libdrm
    libxkbcommon
    pixman
    meson
    gcc
    ninja
    gnumake
    raylib
    libdisplay-info
    hwdata
    seatd
    pcre2
    python315

  ];
  fonts.packages = with pkgs; [
  	nerd-fonts.fira-code
  	nerd-fonts.droid-sans-mono
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
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # Most users should NEVER change this value after the initial install, for any reason,
  system.stateVersion = "25.11"; # Did you read the comment?

}
