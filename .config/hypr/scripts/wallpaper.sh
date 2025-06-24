#!/usr/bin/env bash

result=$(find ~/wallpapers/ -type f \! -name "*_blur.*" |
	sed 's/\/home\/'$USER'/~/' |
	xargs -I {} echo -en "{}\0icon\x1f{}\n" | 
	shuf |
	rofi -dmenu -theme-str '@import "wallpaper.rasi"' |
	sed 's/~/\/home\/'$USER'/'
)

if [ -n "$result" ]; then
	magick "${result}" -scale 11% -blur 0x4 ~/wallpapers/tmp.png;
	hyprctl hyprpaper unload all;
	hyprctl hyprpaper preload "~/wallpapers/tmp.png";
	hyprctl hyprpaper wallpaper ", ~/wallpapers/tmp.png"
fi
