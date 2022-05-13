FROM ruby:2.7


RUN apt-get update
RUN apt-get install aptly --force-yes -y
RUN gem install bundle

EXPOSE 80
VOLUME /app
WORKDIR /app

ENTRYPOINT bin/runindocker.sh
