hm := 'home-manager switch -b backup --flake ".#machine-shop"'

default: switch

switch:
	#!/usr/bin/env bash
	ulimit -n 65535
	if [[ "$(hostname)" == machine-shop* ]]; then
		if command -v home-manager &> /dev/null; then
			{{hm}}
		else
			nix-shell -p home-manager --run '{{hm}}'
		fi
	elif [[ "$(uname)" == "Darwin" ]]; then
		sudo darwin-rebuild switch --flake .
	else
		sudo nixos-rebuild switch --flake .
	fi

update:
	nix flake update
	just switch
