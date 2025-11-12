#!/usr/bin/env -S nu --stdin

# in my helix config:
# [keys.normal."+"]
# "b" = ":sh wl-copy \"%{buffer_name}\""
# "l" = ":sh wl-copy \"%{buffer_name}:%{cursor_line}\""
# "s" = ":pipe-to systemd-run --setenv WAYLAND_DISPLAY --user wl-copy --foreground -- \"$(,hx-quote.nu plain %{buffer_name} %{selection_line_start} %{selection_line_end} %{language})\""
# "g" = ":pipe-to systemd-run --setenv WAYLAND_DISPLAY --user wl-copy --foreground -- \"$(,hx-quote.nu github %{buffer_name} %{selection_line_start} %{selection_line_end} %{language})\""

use ,outdent.nu outdent

def "main github" [buffer_name: string, selection_line_start: int, selection_line_end: int, language:string] {
  let display_path = $"`($buffer_name):($selection_line_start)`"

  let path = try {
    let repo = gh repo view --json url | from json | get url

    let rev = git rev-parse HEAD

    $"[($display_path)]\(($repo)/blob/($rev)/($buffer_name)#L($selection_line_start)-L($selection_line_end)\)"
  } catch {
    $display_path
  }

  $"($path)\n```($language)\n($in | outdent)```"
}

def "main plain" [buffer_name: string, selection_line_start: int, selection_line_end: int, language:string] {
  $"`($buffer_name):($selection_line_start)`\n```($language)\n($in | outdent)```"
}

def main [] {
  help main
}
