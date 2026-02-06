default:
	#!/usr/bin/env bash
	if [[ "$(hostname)" == machine-shop* ]]; then
		home-manager switch --flake ".#$(hostname)"
	elif [[ "$(uname)" == "Darwin" ]]; then
		sudo darwin-rebuild switch --flake .
	else
		sudo nixos-rebuild switch --flake .
	fi

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
