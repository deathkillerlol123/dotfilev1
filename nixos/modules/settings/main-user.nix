{ lib, config, pkgs, ... }:

{
  options = {
    main-user.enable = lib.mkEnableOption "Enable main user module";

    main-user.users = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.any);
      default = [
        { username = "alice"; shell = "bash"; groups = ["wheel"]; flakelocation = "/etc/nixos"; }
        { username = "bob";   shell = "zsh";  groups = ["wheel"]; flakelocation = "/etc/nixos"; }
      ];
      description = "List of users to create with username, shell, groups, and flakelocation";
    };
  };

  config = lib.mkIf config.main-user.enable {

    # Create each user dynamically
    users.users = builtins.listToAttrs (map (user: {
      name = user.username;
      value = {
        isNormalUser = true;
        shell = builtins.getAttr user.shell pkgs;
        extraGroups = user.groups;
      };
    }) config.main-user.users);

    # Add sudo rules per user
    security.sudo.extraRules = map (user: {
      users = [ user.username ];
      commands = [ { command = "ALL"; options = ["NOPASSWD"]; } ];
    }) config.main-user.users;

    # Enable nh and nix-ld globally
    programs.nh.enable = true;
    programs.nh.clean.enable = true;
    programs.nh.flake = "/etc/nixos";

    programs.nix-ld.enable = true;
  };
}