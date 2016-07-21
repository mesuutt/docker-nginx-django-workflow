#!/bin/bash


# Create network
docker network create mynetwork

# Create volume
docker volume create --name=mystatic

# Create DB container
docker run -d \
    --net=mynetwork \
    --name pgdb \
    -e POSTGRES_PASSWORD=12345 \
    postgres

# Build uWSGI+Django image
docker build -t mesuutt/uwsgi-django django/

# Craate Django app containers 
docker run -d \
    --net=mynetwork \
    --name django1 \
    -e DJANGO_SETTINGS_MODULE='myapp.settings.local' \
    -v mystatic:/static \
    mesuutt/uwsgi-django

docker run -d \
    --net=mynetwork \
    --name django2 \
    -e DJANGO_SETTINGS_MODULE='myapp.settings.local' \
    -v mystatic:/static \
    mesuutt/uwsgi-django


# Create nginx container
docker run -d \
    --net=mynetwork \
    --name nginx \
    -p 80:80 \
    -v mystatic:/static \
    -v `pwd`/nginx/myapp.conf:/etc/nginx/conf.d/default.conf \
    nginx


# Create Example app db
docker exec pgdb createdb -U postgres myappdb

# Copy static files of django app to volume
docker cp volume_content/myapp django1:/static/

# Restore example app db backup
docker cp postgres/myappdb.dump pgdb:/
docker exec pgdb psql -U postgres -f /myappdb.dump myappdb

# Create STATIC_ROOT on volume
docker exec django1 /srv/app/manage.py collectstatic --noinput


# Reload apps
docker exec django1 supervisorctl restart app-uwsgi
docker exec django2 supervisorctl restart app-uwsgi


NGINX_CONT_IP=$(docker inspect --format '{{ .NetworkSettings.Networks.mynetwork.IPAddress }}' nginx)

echo "Open: http://nginx or http://$NGINX_CONT_IP"

