#!/usr/bin/env bash

shutdown='⏻'
reboot='󰜉'
suspend=''

yes=''
no=''

result=$(printf "$shutdown;$reboot;$suspend;" |
	rofi -dmenu \
	-sep ';' \
	-theme-str '@import "power.rasi"'
)

case "$result" in 
	$shutdown)
		shutdown
		;;
	$reboot)
		reboot
		;;
	$suspend)
		systemctl suspend
		;;
esac
