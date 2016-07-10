#!/bin/bash

# Create network
docker network create mynetwork

# Create volume
docker volume create --name=mystatic

docker pull postgres
docker pull nginx

docker run -d \
    --net=mynetwork \
    --name pgdb \
    -e POSTGRES_PASSWORD=12345 \
    postgres


docker build mesuutt/uwsgi-django .

docker run -d \
    --net=mynetwork \
    --name django1 \
    -v mystatic:/static \
    mesuutt/uwsgi-django

docker run -d \
    --net=mynetwork \
    --name django2 \
    -v mystatic:/static \
    mesuutt/uwsgi-django


docker run -d \
    --net=mynetwork \
    --name nginx \
    -v mystatic:/static \
    -v `pwd`/nginx.conf:/etc/nginx/conf.d/default.conf \
    nginx



echo 'FINISHED. Open: http://nginx'

