switch:
	sudo nixos-rebuild switch --flake . --impure

update:
	nix flake update
	sudo nixos-rebuild switch --flake .
