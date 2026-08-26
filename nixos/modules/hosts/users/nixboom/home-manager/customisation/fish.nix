{...}: {
  flake.homeModules.nbfish = {...}: {
    programs = {
      fish = {
        enable = true;
        interactiveShellInit = ''
          set -U fish_greeting
          starship init fish | source
          zoxide init fish | source
          cd ~/dotfiles/nixos
          nu
        '';
      };
    };
  };
}
