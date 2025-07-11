#!/usr/bin/env nu

def main [--pr: int] {
  const json_fields = 'number,title,url'

  let pr = if $pr != null {
    gh pr view $pr --json $json_fields | from json
  } else {
    let prs = gh search prs '' --review-requested '@me' --json $json_fields | from json

    $prs | input list --fuzzy --display title
  }

  $"[#($pr.number) ($pr.title)]\(($pr.url)\)" | wl-copy
}
