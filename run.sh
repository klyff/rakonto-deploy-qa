#!/bin/sh

git clone git@github.com:klyff/rakonto-backend.git 2> /dev/null || (cd rakonto-backend ; git pull)
git clone git@github.com:klyff/rakonto-front.git 2> /dev/null || (cd rakonto-front ; git pull)

if [[ ! -z $DROP_DATA ]]; then
  echo removing ~/docker-data
  rm -fr ~/rakonto-data
fi

# docker-compose -f ./rakonto-backend/docker-compose.yml -f ./docker-compose.yml build --no-cache backend
# docker-compose -f ./rakonto-backend/docker-compose.yml -f ./docker-compose.yml build --no-cache frontend
docker-compose -f ./rakonto-backend/docker-compose.yml -f ./docker-compose.yml up --remove-orphans
