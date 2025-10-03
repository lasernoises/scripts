#!/usr/bin/env nu

use std assert

open --raw ($env.FILE_PWD + '/assets/Dockerfile.claude') | docker build --tag localhost/claude -

assert (pwd | str starts-with $'($nu.home-path)/Projects')

(docker run --interactive --tty --rm
  --volume $'($nu.home-path)/.claude.json:/root/.claude.json'
  --volume $'($nu.home-path)/.claude:/root/.claude'
  --volume $'(pwd):(pwd)'
  --workdir (pwd)
  localhost/claude)
