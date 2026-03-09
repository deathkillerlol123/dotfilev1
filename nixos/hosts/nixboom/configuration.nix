{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ../../modules/nbfc.nix
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
    kernelParams = [ "snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" ];
  };
  time.timeZone = "Europe/London"; 
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
      alsa.enable = true;
      wireplumber.enable = true;
      extraConfig.pipewire-pulse."auto-switch" = {
        "pulse.cmd" =[
          { cmd = "load-module"; args = "module-switch-on-connect"; }
        ];
      };
    };
    desktopManager.gnome.enable = true;
    flatpak.enable = true;
    libinput.enable = true;  };
  networking = {
    hostName = "nixbtw";
    networkmanager.enable = true;  };
  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = false;
    };  };
  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    optimise = {
      automatic = true;
      dates = ["20:00"];
    };  };
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
  environment.systemPackages = with pkgs; [
    gdm
    efibootmgr
    os-prober
    lm_sensors
    
    curl 
    wget
    
 		xdg-desktop-portal-hyprland
		xdg-desktop-portal-gtk
		xdg-desktop-portal-wlr
    mangohud
    protonup-qt
    heroic
    nix-search-cli
    brightnessctl
    blueberry
    cavasik
    wlr-randr
    borgbackup
    wdisplays   
    quickshell
    eww
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
    pulseaudio
    wireplumber
   
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
