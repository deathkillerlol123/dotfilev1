{
  lib,
  ...
}:
{
  flake.homeModules.nixboom =
    {
      config,
      inputs,
      pkgs,
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
      tokyo-night-dark-theme = pkgs.fetchurl {
        url = "https://addons.mozilla.org/firefox/downloads/latest/tokyo-night-dark-theme/latest.xpi";
        hash = "1xn8sl1wv52n0xqwh340fimmqjcvi2abqxdqqkl36p2j3h1xrw85";
      };
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
          "org.vinegarhq.Sober"
        ];
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
            vencord.enable = true;
            krisp.enable = true;
          };
          config = {
            useQuickCss = true;
            autoUpdateNotification = true;
            notifyAboutUpdates = true;
            themeLinks = [
              "https://raw.githubusercontent.com/refact0r/midnight-discord/0c6e4b5009df5f13fe33d9b279378378d5212330/themes/midnight.theme.css"
            ];
            plugins = {
              autoDndWhilePlaying.statusToSet = "dnd";
              fakeNitro = {
                enableStreamQualityBypass = true;
              };
              typingTweaks = {
                showAvatars = true;
              };
            };
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
                "extensions.activeThemeID" = "{cebd391d-f568-473f-bb6e-698d08ec81ec}";
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
                tokyo-night-dark-theme
                inputs.firefox-addons.packages."x86_64-linux".bitwarden
                inputs.firefox-addons.packages."x86_64-linux".ublock-origin
                inputs.firefox-addons.packages."x86_64-linux".sidebery
                inputs.firefox-addons.packages."x86_64-linux"."2fas-two-factor-authentication"
              ];
            };
          };
        };
      };
      home = {
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = "25.11";
        file = {
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
      gtk = {
        enable = true;
        theme = {
          name = "Tokyonight-Dark";
          package = pkgs.tokyonight-gtk-theme;
        };
        gtk4.theme = config.gtk.theme;
      };
    };
}
