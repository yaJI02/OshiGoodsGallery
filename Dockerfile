FROM ruby:3.2.2

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
RUN apt-get update -qq \
  && apt-get install -y build-essential libpq-dev libssl-dev postgresql-client

RUN mkdir /oshi_app
WORKDIR /oshi_app

COPY Gemfile /oshi_app/Gemfile
COPY Gemfile.lock /oshi_app/Gemfile.lock

RUN bundle install
COPY . /oshi_app