default:
	#!/usr/bin/env bash
	if [[ "$(hostname)" == machine-shop* ]]; then
		ulimit -n 65535
		home-manager switch --flake ".#machine-shop"
	elif [[ "$(uname)" == "Darwin" ]]; then
		sudo darwin-rebuild switch --flake .
	else
		ulimit -n 65535
		sudo nixos-rebuild switch --flake .
	fi

switch:
	#!/usr/bin/env bash
	if [[ "$(hostname)" == machine-shop* ]]; then
		ulimit -n 65535
		home-manager switch --flake ".#machine-shop"
	elif [[ "$(uname)" == "Darwin" ]]; then
		sudo darwin-rebuild switch --flake .
	else
		ulimit -n 65535
		sudo nixos-rebuild switch --flake .
	fi

update:
	#!/usr/bin/env bash
	nix flake update
	if [[ "$(hostname)" == machine-shop* ]]; then
		ulimit -n 65535
		home-manager switch --flake ".#machine-shop"
	elif [[ "$(uname)" == "Darwin" ]]; then
		sudo darwin-rebuild switch --flake .
	else
		ulimit -n 65535
		sudo nixos-rebuild switch --flake .
	fi
