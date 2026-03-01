# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

#  boot.loader.systemd-boot.enable = true;

  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = ["nodev"];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  boot.kernelParams = [ "snd_hda_intel.dmic_detect=0" "snd_intel_dspcfg.dsp_driver=1" ];

  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
   };

  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.flatpak.enable = true;
  
  networking.hostName = "nixbtw"; # Define your hostname.

  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  time.timeZone = "Europe/London";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  #services.xserver.enable = true;
  

  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  services.libinput.enable = true;

  home-manager = {

  	extraSpecialArgs = {inherit inputs; };
	users = {
		"nixboom" = import ./home.nix;
	};
  };

  #Define a user account. Don't forget to set a password with ‘passwd’.
 users.users.nixboom = {
   isNormalUser = true;
   shell = pkgs.zsh;
   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   packages = with pkgs; [
     tree
   ];
 };

  programs.zsh.enable = true;
  programs.mangowc.enable = true;

  nixpkgs.config = {
  	allowUnfree = true;
  };
  programs.steam = {
  	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
	
	gamescopeSession.enable = true;

  };
  programs.gamemode.enable = true;

  # List packages installed in system profile.
  #You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    lutris
    heroic
    #bottles

    wget
    neovim
    kitty
    borgbackup
    swaynotificationcenter
    swaybg
    btop
    cmatrix
    neofetch
    ranger
    zellij
    nautilus
    copyq
    ntfs3g
    bat
    rofi
    firefox-devedition

    warehouse

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
    ninja
    libdisplay-info
    hwdata
    seatd
    pcre2

    eza
    wlr-randr
    whatsapp-electron

    python315


    zed-editor
    stow
    starship
    bash
    zsh
    git
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

