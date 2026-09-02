{self, ...}: {
  flake.homeModules.nixboom = {
    config,
    lib,
    ...
  }: let
    user = "nixboom";
    dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/${user}/dotfiles/nixos/modules/hosts/users/${user}/home";
    conf = "${dotfiles}/.config";
    mkFile = names:
      lib.genAttrs names (name: {
        source = "${dotfiles}/${name}";
      });
    mkconf = names:
      lib.listToAttrs (
        map (name: {
          name = ".config/${name}";
          value = {
            source = "${conf}/${name}";
            recursive = true;
            force = true;
          };
        })
        names
      );
  in {
    imports = with self.homeModules; [packages custom_scripts nbgtk nbgit nbdesktop nbmango nbfirefox nbdiscord nbstarship nbfish nbnu];
    programs.home-manager.enable = true;
    home = {
      username = user;
      homeDirectory = "/home/${user}";
      stateVersion = "25.11";
      file =
        (mkconf ["rofi" "ghostty"])
        // (mkFile [".emacs"]);
    };
  };
}
