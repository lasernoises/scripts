#!/usr/bin/env nu
swaymsg 'output eDP-1 disable'
swaymsg 'output DP-2 enable mode 2560x1440 pos 1440 447 transform normal'
swaymsg 'output DP-1 enable mode 2560x1440 pos 0 0 transform 270'
