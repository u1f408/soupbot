FROM docker.io/ruby:3.3-alpine as deps

WORKDIR /app
COPY Gemfile /app
COPY Gemfile.lock /app
RUN apk add --no-cache git build-base \
    && bundle config set deployment true \
    && bundle install \
    && apk del git build-base

FROM deps

WORKDIR /app
COPY . /app
CMD bundle exec ruby bot.rb
