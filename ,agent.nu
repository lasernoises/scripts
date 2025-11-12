#!/usr/bin/env nu

use std assert
use secrets.nu

let base_path = $nu.home-dir + '/agents/'

def list [] {
  ls $base_path | get name | path basename
}

def run_agent [name: string] {
  let path = $base_path + $name

  # (docker run
  #   --rm
  #   --interactive
  #   --tty
  #   --volume $'($nu.home-dir)/.claude.json:/home/claude/.claude.json'
  #   --volume $'($nu.home-dir)/.claude:/home/claude/.claude'
  #   --volume $'($path):/code'
  #   --workdir /code
  #   --user $'(id --user):(id --group)'
  #   localhost/claude)

  # (docker run
  #   --rm
  #   --interactive
  #   --tty
  #   --volume $'($nu.home-dir)/.pi:/home/pi/.pi'
  #   --volume $'($path):/code'
  #   --env $'CEREBRAS_API_KEY=($secrets.CEREBRAS_API_KEY)'
  #   --workdir /code
  #   --user $'(id --user):(id --group)'
  #   localhost/pi)

  (docker run
    --rm
    --interactive
    --tty
    --volume $'($nu.home-dir)/.config/maki:/home/maki/.config/maki'
    --volume $'($nu.home-dir)/.cache/maki:/home/maki/.cache/maki'
    --volume $'($nu.home-dir)/.local/share/maki:/home/maki/.local/share/maki'
    --volume $'($nu.home-dir)/.local/state/maki:/home/maki/.local/state/maki'
    --volume $'($path):/code'
    --env $'ANTHROPIC_API_KEY=($secrets.ANTHROPIC_API_KEY)'
    --workdir /code
    --user $'(id --user):(id --group)'
    localhost/maki --yolo)
}

def "main update" [] {
  open --raw ($env.FILE_PWD + '/assets/Dockerfile.maki') | docker build --pull --no-cache --tag localhost/maki -
}

def "main new" [] {
  assert (
    (pwd | str starts-with $'($nu.home-dir)/Projects') or
    (pwd | str starts-with $'($nu.home-dir)/clones')
  )

  let prefix = (pwd | path basename) + '-'

  let name = input $'name: ($prefix)'

  let name = $prefix + $name

  let path = $base_path + $name

  if ($path | path exists) {
    error make { msg: $'Agent ($name) already exists!' }
  }

  # cp --progress --recursive . $path

  mkdir $path
  # ^cp --reflink=always --recursive . $path
  jj workspace add $path

  run_agent $name
}

def "main new-empty" [] {
  let name = input "name: "

  let path = $base_path + $name

  if ($path | path exists) {
    error make { msg: $'Agent ($name) already exists!' }
  }

  mkdir $path

  run_agent $name
}

def "main ls" [] {
  list
}

def "main run" [] {
  let name = (list | input list)

  run_agent $name
}

def "main" [] {
  help main
}
