#!/bin/sh

git clone git@github-dgc.com:klyff/rakonto-backend.git 2> /dev/null || (cd rakonto-backend ; git pull)
git clone git@github-dgc.com:klyff/rakonto-ui.git 2> /dev/null || (cd rakonto-ui ; git pull)

docker rmi --force $(docker images 'rakonto-deploy-qa_rakonto' -a -q)
docker-compose up --remove-orphans