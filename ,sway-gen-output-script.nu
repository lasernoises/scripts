#!/usr/bin/env nu

let outputs = swaymsg --raw --type get_outputs | from json | sort-by active

print "#!/usr/bin/env nu"

for output in $outputs {
     if $output.active {
          # TODO: refresh rate
          print $"swaymsg 'output ($output.name) enable mode ($output.current_mode.width)x($output.current_mode.height) pos ($output.rect.x) ($output.rect.y) transform ($output.transform)'"
     } else {
          print $"swaymsg 'output ($output.name) disable'"
     }
}

# $command
