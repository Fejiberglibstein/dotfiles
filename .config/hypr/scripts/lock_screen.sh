#!/usr/bin/env bash

LOCK_IMG=$(find ~/wallpapers/ -type f | shuf | head -n 1) hyprlock
