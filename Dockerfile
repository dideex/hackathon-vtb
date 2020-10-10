FROM elixir:1.10.3-alpine

RUN      apk update && \
         apk upgrade && \
         apk --no-cache add \
         git openssh openssl-dev && \
         apk add \
         build-base && \
         mix local.rebar --force && \
         mix local.hex --force && \
         apk add --update nodejs nodejs-npm
         

WORKDIR  /opt/app

COPY     . ./

RUN      mix do deps.get, deps.compile