FROM ruby:2.3.0
COPY ./ /web_app
WORKDIR /web_app
RUN bundle install
CMD ruby ./web.rb -o 0.0.0.0
