FROM hexpm/elixir:1.14.2-erlang-25.2-debian-bullseye-20221004-slim

ARG MIX_ENVIRONMENT=dev

ENV MIX_HOME=/opt/mix
ENV MIX_ENV=${MIX_ENVIRONMENT}

# Install debian packages
RUN apt-get update && \
    apt-get install --yes build-essential inotify-tools postgresql-client git && \
    apt-get clean

ADD . /app

# Install Phoenix packages
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force hex phx_new 1.6.15

WORKDIR /app

RUN mix deps.get
RUN mix compile

EXPOSE 4000
