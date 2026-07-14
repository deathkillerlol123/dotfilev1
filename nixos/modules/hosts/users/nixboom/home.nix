{
  lib,
  ...
}:
{
  flake.homeModules.nixboom =
    {
      config,
      inputs,
      ...
    }:
    let
      user = "nixboom";
      gitidentity = {
        user = {
          name = "deathkillerlol123";
          email = "81639935+deathkillerlol123@users.noreply.github.com";
        };
      };
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
    in
    {
      imports = [
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
        inputs.nixcord.homeModules.nixcord
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
        emacs.enable = true;
        git = {
          enable = true;
          settings = gitidentity // {
            init.defaultBranch = "main";
            credential.helper = "!gh auth git-credential";
          };
        };
        jujutsu = {
          enable = true;
          settings = gitidentity // {
            ui = {
              default-command = [
                "log"
                "-r"
                "ancestors(@,5)"
              ];
            };
          };
        };
        nixcord = {
          enable = true;
          discord = {
            openASAR.enable = true;
            silenceNoModClientWarning = true;
          };
          config = {
            useQuickCss = true;
            autoUpdateNotification = true;
            themeLinks = [
              "https://github.com/refact0r/midnight-discord/blob/0c6e4b5009df5f13fe33d9b279378378d5212330/themes/midnight.theme.css"
            ];
            frameless = true;
          };
        };
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
      home.file = {
        ".local/share/applications" = {
          source = "${dotfiles}/.local/share/applications";
          recursive = true;
        };
      }
      // (mkconf [
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
      ]);
    };
}
