FROM ruby:2.3.0
COPY ./ /app
ADD Gemfile /app
ADD Gemfile.lock /app
WORKDIR /app
RUN bundle install --without development test