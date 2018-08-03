#!/bin/sh
echo "
         ######################################
         ###       compose file test         ##
         ######################################
"


# Make sure tests fails if a commend ends without 0
set -e

sed -i 's/image: hackmdio\/hackmd:1.2.0/image: hackmd:testing/' ./docker-compose.yml

docker-compose pull database

docker-compose up -d

sleep 30

docker-compose ps

wget -O- http://127.0.0.1:3000/

docker-compose ps

docker-compose logs

# Clean up
docker-compose down -v
