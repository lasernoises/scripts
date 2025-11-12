#!/usr/bin/env nu

def main [--full, --pre] {
  let path = $"($env.HOME)/sync_flo/screenshots/(^date "+%Y-%m-%d_%H:%M:%S").png"

  if $full {
    grim $path
  } else if $pre {
    let area = slurp
  
    let next = ("continue\nabort" | wmenu)

    if $next == "continue" {
      $area | grim -g - $path
    }
  } else {
    slurp | grim -g - $path
  }

  cat $path | wl-copy
}
