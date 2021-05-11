#!/bin/sh

git clone git@github-dgc.com:klyff/rakonto-backend.git 2> /dev/null || (cd rakonto-backend ; git pull)
git clone git@github-dgc.com:klyff/rakonto-ui.git 2> /dev/null || (cd rakonto-ui ; git pull)

docker-compose up --remove-orphans