FROM ruby:3.0
ENV APP /myapp
RUN mkdir -p $APP
WORKDIR $APP
COPY . $APP/
RUN bundle install
