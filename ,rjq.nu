#!/usr/bin/env nu

def main [filter: string, path: path] {
  for file in (ls ($path | into glob)) {
  # for file in (ls ($'($path)/**/*.json' | into glob)) {
    let out = jq $filter $file.name
    if $out != '' {
      print $'($file.name):'
      # print $out
    }
  }
}
