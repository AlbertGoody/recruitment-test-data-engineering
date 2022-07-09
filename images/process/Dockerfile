FROM ruby:3.1

WORKDIR /app

COPY Gemfile ./
RUN bundle install

COPY place.rb ./
COPY person.rb ./
COPY process.rb ./
