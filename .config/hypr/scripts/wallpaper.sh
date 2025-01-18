#!/usr/bin/env bash

result=$(find ~/wallpapers/ |
	sed 's/\/home\/'$USER'/~/' |
	xargs -I {} echo -en "{}\0icon\x1f{}\n" | 
	shuf |
	rofi -dmenu \
	-theme-str '@import "wallpaper.rasi"' \
)

if [ -n "$result" ]; then
	hyprctl hyprpaper unload all
	hyprctl hyprpaper preload "$result"
	hyprctl hyprpaper wallpaper ", $result"
fi
