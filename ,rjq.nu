#!/usr/bin/env nu

def main [--output, filter: string, ...path: path] {
  for file in (^find ...$path -name '*.json' | lines) {
    try {
      let out = jq $filter $file

      if $out != '' {
        print $'($file)(if $output { ':' } else { '' })'

        if $output {
          print $out
        }
      }
    } catch {
      print --stderr $"Error in ($file)!"
      exit 1
    }
  }
}
