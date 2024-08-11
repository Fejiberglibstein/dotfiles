#!/usr/bin/env bash

result=$(fd . ~/wallpapers/ |
	xargs -I {} echo -en "{}\0icon\x1f{}\n" |
	rofi -dmenu \
	-theme-str '@import "wallpaper.rasi"' \
)

if [ -n "$result" ]; then
	hyprctl hyprpaper unload all
	hyprctl hyprpaper preload "$result"
	hyprctl hyprpaper wallpaper ", $result"
fi
