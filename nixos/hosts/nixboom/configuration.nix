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
      windowManager.qtile.enable = true;
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
	extraPortals = [
		pkgs.xdg-desktop-portal-hyprland
		pkgs.xdg-desktop-portal-gtk
	];
  };

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    optimise = {
      automatic = true;
      dates = ["20:00"];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than-1d";
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
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
  environment.systemPackages = with pkgs; [
    gdm
    efibootmgr

    nix-search-cli
    blueberry

    mangohud
    protonup-qt
    lutris
    heroic
    #bottles

    wget
    borgbackup
    swaynotificationcenter
    swaybg
    swaylock
    wlogout

    zoxide
    fzf

    kitty
    starship
    zsh
    bash
    neovim
    btop
    cmatrix
    neofetch
    ranger
    zellij
    nautilus
    copyq
    ntfs3g
    bat
    eza

    git
    gh

    rofi
    firefox-devedition


    grim
    slurp
    wl-clipboard
    swappy

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

    wlr-randr
    wdisplays
    whatsapp-electron
    discord-ptb
    zed-editor
    stow
    waybar
    swww
    pywal
    kdePackages.gwenview
    playerctl
    alsa-utils
    pavucontrol
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

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

