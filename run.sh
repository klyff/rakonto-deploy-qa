#!/bin/sh

git clone git@github.com:klyff/rakonto-backend.git 2> /dev/null || (cd rakonto-backend ; git pull)
git clone git@github.com:klyff/rakonto-ui.git 2> /dev/null || (cd rakonto-ui ; git pull)

if [[ ! -z $DROP_DATA ]]; then
  echo removing ~/docker-data
  rm -fr ~/rakonto-data
fi

cp rakonto-backend/docker-compose.yml . && cp -R rakonto-backend/docker .

cat <<EOT >> docker-compose.yml

  rakonto:
    build: .
    ports:
      - 8080:8080
    volumes:
      - ~/rakonto-data/docker/binary:/app/uploads
    depends_on:
      - mysql
      - rabbitmq
EOT

docker rmi --force $(docker images 'rakonto-deploy-qa_rakonto' -a -q) 2> /dev/null
docker-compose up --remove-orphans
