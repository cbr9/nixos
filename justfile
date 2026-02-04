switch:
	#!/usr/bin/env bash
	if [[ "$(uname)" == "Darwin" ]]; then
		sudo darwin-rebuild switch --flake .
	else
		sudo nixos-rebuild switch --flake .
	fi

update:
	#!/usr/bin/env bash
	nix flake update
	if [[ "$(uname)" == "Darwin" ]]; then
		sudo darwin-rebuild switch --flake .
	else
		sudo nixos-rebuild switch --flake .
	fi
