#!/usr/bin/env bash

grim -g "$(slurp -b#00000040 -c#705cad -F"CaskaydiaCove Nerd Font" -d)" - \
    | convert - -shave 1x1 PNG:- \
    | swappy -f - -o - \
    | wl-copy

