{lib, config, pkgs, ...}: {
  options = {
    main-user = lib.mkOption {
      type = lib.types.listOf {
        type = rec {
          userName = lib.mkOption { type = lib.types.string; };
          shell = lib.mkOption { type = lib.types.string; default = "bash"; };
          flakelocation = lib.mkOption { type = lib.types.string; default = "/etc/nixos/"; };
          groups = lib.mkOption { type = lib.types.listOf lib.types.string; default = [ "wheel" ]; };
          enable = lib.mkOption { type = lib.types.bool; default = true; };
        };
      };
      default = [];
    };
  };

  config = lib.mkIf (lib.any (user: user.enable) config.main-user) {
    # Create users based on the list
    users.users = lib.foldl' (acc, user: acc // {
      # Use index to access the list element
      ${user.userName} = {
        isNormalUser = true;
        shell = pkgs.${user.shell};
        extraGroups = user.groups;
      };
    }) {} (filter (user: user.enable) config.main-user);

    # Set sudo rules for users
    security.sudo.extraRules = lib.concatLists (map (user: {
      users = [ user.userName ];
      commands = [{
        command = "ALL";
        options = [ "NOPASSWD" ];
      }];
    }) (filter (user: user.enable) config.main-user));

    # Access flakelocation from the first user in the list
    # Or handle multiple users as needed
    config.programs = {
      bash.enable = true;
      zsh.enable = true;
      nh = {
        enable = true;
        clean.enable = true;
        # Access flakelocation of the first user
        flake = if (length config.main-user > 0)
                then config.main-user[0].flakelocation
                else "/default/path";
      };
      nix-ld = {
        enable = true;
      };
    };
  };
}