FROM python:3.4

MAINTAINER Mesut Tasci

ENV PYTHONUNBUFFERED 1

RUN apt-get update
RUN apt-get install --no-install-recommends -y supervisor


RUN pip install --upgrade pip
RUN pip install uwsgi


ENV USER=uwsgi
ENV UID=1000

# Run uwsgi unpriviledged
RUN groupadd uwsgi && useradd -g uwsgi -u $UID -m $USER

COPY . /srv/
RUN ln -s /srv/supervisor-app.conf /etc/supervisor/conf.d/

RUN pip install -r /srv/app/requirements.txt

RUN chown -R uwsgi:uwsgi /srv/app


EXPOSE 9000

CMD ["supervisord", "-n"]
