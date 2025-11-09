#!/usr/bin/env nu

let id = (docker run
  --pull always
  --detach
  --volume $'($env.HOME)/Documents/nocodb:/usr/app/data/'
  --name nocodb
  --publish 1024:8080
  nocodb/nocodb:latest)

chromium --new-window --app=http://localhost:1024

docker stop $id
docker rm $id
