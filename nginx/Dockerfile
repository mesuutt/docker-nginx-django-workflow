FROM nginx

MAINTAINER Mesut Tasci

# I am creating a user with specified UID and run nginx container with it.
# Because I am using nginx for serving static files of my app container.
# Nginx user and webserver user must have same UID for not getting permission error.
# I am creating users with UID=1000 on django container and nginx images.
# In this way nginx can serve upladed files by django containers.

ENV USER=docker
ENV UID=1000

RUN useradd -u $UID -m $USER

# Remove default virtual host file
RUN rm /etc/nginx/conf.d/default

# Replace nginx.conf with our nginx.conf which user changed
COPY nginx.conf /etc/nginx/nginx.conf

# Change nginx user
RUN envsubst < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf

