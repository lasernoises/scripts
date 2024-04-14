#!/usr/bin/env nu

def main [page: string] {
    man -Tpdf $page out> ~/tmp/man.pdf
    zathura ~/tmp/man.pdf
}
