#!/usr/bin/env nu

use std assert

let base_path = $nu.home-dir + '/agents/'

def list [] {
  ls $base_path | get name | path basename
}

def run [name: string] {
  let path = $base_path + $name

  (docker run
    --rm
    --interactive
    --tty
    --volume $'($nu.home-dir)/.claude.json:/home/claude/.claude.json'
    --volume $'($nu.home-dir)/.claude:/home/claude/.claude'
    --volume $'($path):/code'
    --workdir /code
    --user $'(id --user):(id --group)'
    localhost/claude)
}

def "main update" [] {
  open --raw ($env.FILE_PWD + '/assets/Dockerfile.claude') | docker build --tag localhost/claude -
}

def "main new" [] {
  assert (pwd | str starts-with $'($nu.home-dir)/Projects')

  let prefix = (pwd | path basename) + '-'

  let name = input $'name: ($prefix)'

  let name = $prefix + $name

  let path = $base_path + $name

  if ($path | path exists) {
    error make { msg: $'Agent ($name) already exists!' }
  }

  # cp --progress --recursive . $path

  mkdir $path
  ^cp --reflink=always --recursive . $path

  run $name
}

def "main ls" [] {
  list
}

def "main run" [] {
  let name = (list | input list)

  run $name
}

def "main" [] {
  help main
}
