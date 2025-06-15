#!/usr/bin/env nu

start (ls --long ~/tmp | sort-by --reverse created | first | get name)
