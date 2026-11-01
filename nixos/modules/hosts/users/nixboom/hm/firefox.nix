{inputs, ...}: {
  flake.homeModules.nbfirefox = {config, ...}: let
    firefox_user = "declaritive";
    fire-addons = inputs.firefox-addons.packages."x86_64-linux";
  in {
    programs = {
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
              "privacy.trackingprotection.socialtracking.enabled" = true;
              "browser.contentblocking.category" = "strict";
              "browser.tabs.groups.smart.enabled" = false;
              "privacy.trackingprotection.enabled" = true;
              "browser.urlbar.suggest.searches" = false;
              "media.hardwaremediakeys.enabled" = true;
              "ui.key.menuAccessKeyFocuses" = false;
              "extensions.autoDisableScopes" = 0;
              "browser.ml.chat.enabled" = false;
              "network.prefetch-next" = false;
              "general.autoScroll" = true;
              "browser.ml.enable" = false;
              "sidebar.revamp" = false;
            };
            userChrome = ''
              #TabsToolbar {
                  visibility: collapse !important;
                  height: 0 !important;
                  min-height: 0 !important;
                  max-height: 0 !important;
               }
            '';
            #https://addons.mozilla.org/en-GB/firefox/addon/voxtyper/
            extensions.packages = with fire-addons; [bitwarden ublock-origin sidebery darkreader];
          };
        };
      };
    };
  };
}
