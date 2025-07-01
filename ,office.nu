#!/usr/bin/env nu
swaymsg 'output eDP-1 disable'
swaymsg 'output HDMI-A-2 enable mode 2560x1440 pos 0 588 transform normal'
swaymsg 'output DP-1 enable mode 2560x1440 pos 2560 0 transform 270'
