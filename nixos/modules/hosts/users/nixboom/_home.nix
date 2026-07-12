{
  config,
  pkgs,
  lib,
  inputs,
  self,
  ...
}:
let
  user = "nixboom";
  dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/${user}/dotfiles/nixos/dots/${user}/";
  firefox_user = "declaritive";
  conf = "${dotfiles}/.config";
  mkFile =
    names:
    lib.genAttrs names (name: {
      source = "${dotfiles}/${name}";
    });
  mkconf =
    names:
    lib.listToAttrs (
      map (name: {
        name = ".config/${name}";
        value = {
          source = "${conf}/${name}";
          recursive = true;
        };
      }) names
    );
  mkdirs =
    paths:
    lib.genAttrs paths (path: {
      source = "${dotfiles}/${path}";
      recursive = true;
    });
in
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
  services.flatpak = {
    update.onActivation = true;
    packages = [
      "ch.openboard.OpenBoard"
      "org.vinegarhq.Sober"
    ];
  };
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "25.11";
  };
  programs = {
    home-manager.enable = true;
    firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisplayBookmarksToolBar = "never";
      };
      profiles = {
        ${firefox_user} = {
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.startup.homepage" = "https://search.nixos.org/packages";
            "privacy.trackingprotection.enabled" = true;
          };
          userChrome = ''
            #TabsToolbar {
                visibility: collapse !important;
                height: 0 !important;
                min-height: 0 !important;
                max-height: 0 !important;
             }
          '';
          extensions.packages = [
            inputs.firefox-addons.packages."x86_64-linux".bitwarden
            inputs.firefox-addons.packages."x86_64-linux".ublock-origin
            inputs.firefox-addons.packages."x86_64-linux".sidebery
            inputs.firefox-addons.packages."x86_64-linux"."2fas-two-factor-authentication"
          ];
        };
      };
    };
  };
  home.file =
    (mkconf [
      "mango"
      "swaylock"
      "fastfetch"
      "fish"
      "waybar"
      "walrus"
      "wallust"
      "swaync"
      "rofi"
      "mako"
      "qutebrowser"
      "ghostty"
    ])
    // (mkFile [
      ".emacs"
      ".wezterm.lua"
      ".config/starship.toml"
    ])
    // (mkdirs [
      ".local/share/applications"
    ]);
  programs.emacs.enable = true;
}
