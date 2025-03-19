#!/usr/bin/env nu
swaymsg 'output eDP-1 disable'
swaymsg 'output DP-1 enable mode 2560x1440 pos 0 0 transform 270'
swaymsg 'output HDMI-A-2 enable mode 2560x1440 pos 1440 581 transform normal'
