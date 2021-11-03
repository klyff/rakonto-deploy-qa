#!/bin/sh

git clone git@github.com:klyff/rakonto-backend.git 2> /dev/null || (cd rakonto-backend ; git pull)
git clone git@github.com:klyff/rakonto-ui.git 2> /dev/null || (cd rakonto-ui ; git pull)

if [[ ! -z $DROP_DATA ]]; then
  echo removing ~/docker-data
  rm -fr ~/rakonto-data
fi

sudo chown -R 1000:1000 ~/rakonto-data/docker/elasticsearch

docker-compose -f ./rakonto-backend/docker-compose.yml -f ./docker-compose.yml build backend
docker-compose -f ./rakonto-backend/docker-compose.yml -f ./docker-compose.yml build frontend
docker-compose -f ./rakonto-backend/docker-compose.yml -f ./docker-compose.yml up -d --remove-orphans
