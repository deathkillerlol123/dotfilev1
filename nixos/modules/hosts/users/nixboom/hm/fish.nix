{...}: {
  flake.homeModules.nbfish = {...}: {
    programs = {
      fish = {
        enable = true;
        generateCompletions = false;
        interactiveShellInit = ''
          set -U fish_greeting
          starship init fish | source
          zoxide init fish | source
        '';
      };
    };
  };
}
