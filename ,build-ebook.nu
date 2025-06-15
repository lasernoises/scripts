#!/usr/bin/env nu

cd ~/Documents/books/input

let file = ls *.html | get name | input list --fuzzy

let title = htmlq --filename $file --text title

htmlq --remove-nodes '#toolbar' --filename $file
  | pandoc --from html --to markdown_strict-raw_html --
  | (pandoc
    --from markdown_strict
    --to epub-raw_html
    --output $"../($file | path parse | get stem).epub"
    --metadata $"title:($title)"
    --
  )
