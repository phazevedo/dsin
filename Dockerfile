FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs redis-server
RUN mkdir DSIN
WORKDIR /DSIN
COPY Gemfile /DSIN/Gemfile
COPY Gemfile.lock /DSIN/Gemfile.lock
RUN bundle install
COPY . /DSIN