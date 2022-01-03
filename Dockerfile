FROM ruby:3.0
ENV APP /myapp
RUN mkdir -p $APP
WORKDIR $APP
COPY . $APP/
RUN apt-get update -qq && apt-get -y install \
  imagemagick \
  && bundle install
