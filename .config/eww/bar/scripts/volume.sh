#!/usr/bin/env bash

handle_change() {
  while read -r line; do
	if echo "$line" | grep -q "change"; then
	  echo $(pactl get-sink-volume 0 | awk '{print $5}' | sed 's/%//g');
	fi
  done
}

pactl subscribe | handle_change
