let FZF_BINDINGS = {
	tab: toggle-out,
	shift-tab: toggle-in
}

$env.FZF_DEFAULT_OPTS = $"--bind ($FZF_BINDINGS | to text | lines | str join ',' | str replace --all ' ' '')"

