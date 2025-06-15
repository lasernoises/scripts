#!/usr/bin/env nu

let chosen = open $'($env.FILE_PWD)/assets/emoji.txt' |
    | str replace --all --regex --multiline '^(.*?);.*$' '$1'
    | wmenu -i -l 30
    | str replace --regex '(.*?) .*' '$1'

$chosen | wl-copy

# notify-send $"'($chosen)' copied to clipboard."
