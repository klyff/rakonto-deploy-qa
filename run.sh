#!/bin/sh

git clone git@github.com:klyff/rakonto-backend.git 2> /dev/null || (cd rakonto-backend ; git pull)
git clone git@github.com:klyff/rakonto-ui.git 2> /dev/null || (cd rakonto-ui ; git pull)

docker container kill $(docker ps -q) 2> /dev/null

case $(uname | tr '[:upper:]' '[:lower:]') in
  linux*)
    sudo chown -R 1000:1000 ~/rakonto-data/docker/elasticsearch
    ;;
esac

docker-compose -f ./rakonto-backend/docker-compose.yml -f ./docker-compose.yml build backend
docker-compose -f ./rakonto-backend/docker-compose.yml -f ./docker-compose.yml build frontend
docker-compose -f ./rakonto-backend/docker-compose.yml -f ./docker-compose.yml up -d --remove-orphans
