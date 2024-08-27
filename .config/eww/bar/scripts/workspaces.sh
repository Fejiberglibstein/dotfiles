#!/usr/bin/env bash
# https://wiki.hyprland.org/Useful-Utilities/Status-Bars/#configewwscriptsget-active-workspace

active(){
	hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id'
}

all() {
	WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries')
	seq 1 10 | jq --argjson windows "${WORKSPACE_WINDOWS}" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})'
}

case $1 in 
	"active")
		active
		;;
	"all")
		all
		;;
esac

