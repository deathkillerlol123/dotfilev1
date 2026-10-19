{self, ...}: {
  flake.homeModules.nixboom = {config, ...}: let
    user = "nixboom";
    dotfiles = config.lib.file.mkOutOfStoreSymlink "/home/${user}/dotfiles/nixos/modules/hosts/users/${user}/home";
  in {
    imports = with self.homeModules; [nbpackages nbcustom_scripts nbgtk nbgit nbdesktop nbmango nbfirefox nbdiscord nbstarship nbfish nbnu nbghostty nbfuzzel];
    home = {
      file = {
        ".emacs".source = "${dotfiles}/.emacs";
        ".config/fuzzel/fuzzel.ini".source = "${dotfiles}/.config/fuzzel/fuzzel.ini";
      };
    };
  };
}
