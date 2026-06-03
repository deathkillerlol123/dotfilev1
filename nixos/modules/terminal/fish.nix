{inputs,self,...}:{
  flake.nixosModules.fish = {config,lib,pkgs,inputs,...}:
  {
    programs.fish = {
      enable = true;
      shellAliases = {
        gu="~/dotfiles/nixos/scripts/git_updater.sh";
	up="~/dotfiles/nixos/scripts/system_updaters/updatesys_Nixos.sh";
  	w="~/dotfiles/nixos/scripts/Boot-Windows10.sh";
  	n="gu && sudo nixos-rebuild switch --flake ~/dotfiles/nixos";	
  	t="gu && up";
  	ls="eza -a --tree -L 1";
  	e="emacs -nw";
  	s="statix check ~/dotfiles/nixos";
      };
    };
  };
}