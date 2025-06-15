#!/usr/bin/env nu

let path = $"($env.HOME)/sync_flo/screenshots/(^date "+%Y-%m-%d_%H:%M:%S").png"
slurp | grim -g - $path

cat $path | wl-copy
