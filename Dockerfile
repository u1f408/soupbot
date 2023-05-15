FROM ruby:3.1-alpine as deps

WORKDIR /app
COPY Gemfile /app
COPY Gemfile.lock /app
RUN apk add --no-cache git build-base && bundle install && apk del git build-base

FROM deps

WORKDIR /app
COPY . /app
CMD bundle exec ruby bot.rb
