#!/usr/bin/env nu
swaymsg 'output eDP-1 disable'
swaymsg 'output HDMI-A-2 enable mode 2560x1440 pos 1785 0 transform normal'
swaymsg 'output DP-1 enable mode 2560x2880 pos -775 -763 transform normal'
