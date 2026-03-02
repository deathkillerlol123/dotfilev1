{config,pkgs, ...}:

{
 imports = [
 	./nvim/autocmds.nix
	./nvim/core.nix
	./nvim/init.nix
	./nvim/keymaps.nix
	./nvim/lazy.nix
	./nvim/lazyvim.nix
	./nvim/snips.nix
	./nvim/stylua.nix
 ];
}
