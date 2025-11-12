#!/usr/bin/env -S nu --stdin

# A bit of a hacky way to remove common leading spaces from some text.
export def outdent [] {
  let lines = $in | lines

  let min_indent = $lines
    | each {|line| if $line == "" { null } else {
      ($line | str length) - ($line | str trim --left --char ' ' | str length)
    } }
    | math min

  let trailing_newline = $in | str ends-with "\n"

  ($lines
    | each {|line| $line | str substring $min_indent..($line | str length) }
    | str join "\n") + (if $trailing_newline { "\n" } else { "" })
}

def main [] { outdent }
