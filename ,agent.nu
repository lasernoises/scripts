#!/usr/bin/env nu

use std assert
use secrets.nu

def run_agent [path: string] {
  let relative_path = $path | path relative-to $nu.home-dir

  # This will blow up in our face if we ever allow running agents in arbirary directories because of
  # nesting.
  mkdir ($nu.home-dir)/.local/state/agent/($relative_path)/.local/state/maki
  mkdir ($nu.home-dir)/.local/state/agent/($relative_path)/.config/jj

  (docker run
    --rm
    --interactive
    --tty
    --volume ($nu.home-dir)/.config/maki:/home/maki/.config/maki
    --volume ($nu.home-dir)/.cache/maki:/home/maki/.cache/maki
    --volume ($nu.home-dir)/.local/state/agent/($relative_path)/.config/jj:/home/maki/.config/jj
    --volume ($nu.home-dir)/.config/agent/jj:/home/maki/.config/jj/config.toml
    --volume ($nu.home-dir)/.local/state/agent/($relative_path)/.local/state/maki:/home/maki/.local/state/maki
    --volume ($nu.home-dir)/.local/state/maki/auth:/home/maki/.local/state/maki/auth
    --volume ($path):($path)
    --env ANTHROPIC_API_KEY=($secrets.ANTHROPIC_API_KEY)
    --env PURPUR_OUTLINE_API_KEY=($secrets.PURPUR_OUTLINE_API_KEY)
    --workdir $path
    --user (id --user):(id --group)
    localhost/maki)
}

def "main update" [--cache] {
  open --raw ($env.FILE_PWD + '/assets/Dockerfile.maki')
    | docker build --pull ...(if $cache {[]} else {[--no-cache]}) --tag localhost/maki -
}

def "main run" [] {
  let parent_dir = pwd | path parse | get parent

  assert (
    ($parent_dir | str starts-with $'($nu.home-dir)/Projects') or
    ($parent_dir | str starts-with $'($nu.home-dir)/clones') or
    ($parent_dir | str starts-with $'($nu.home-dir)/purpur/projects')
  )

  run_agent (pwd)
}

def "main" [] {
  help main
}
