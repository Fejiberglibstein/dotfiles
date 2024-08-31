#!/usr/bin/env bash
# https://wiki.hyprland.org/Useful-Utilities/Status-Bars/#configewwscriptsget-active-workspace

active(){
	hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id'
	socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
		hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id'
	done
}

LAST_VAL=""
all() {
	WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries')
	VAL=$(seq 1 10 | jq --argjson windows "${WORKSPACE_WINDOWS}" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})')
	if [[ "$VAL" != "$LAST_VAL" ]]; then
		echo "$VAL"
		LAST_VAL="$VAL"
	fi
}

case $1 in 
	"active")
		active
		;;
	"all")
		all
		socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
			all
		done
		;;
esac

