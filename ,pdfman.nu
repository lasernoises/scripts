#!/usr/bin/env nu

def main [page: string] {
    let file = mktemp --tmpdir-path ~/tmp
    man -Tpdf $page out> $file
    zathura $file
    rm $file
}
