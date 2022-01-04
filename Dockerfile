FROM ruby:3.0

ARG WORKDIR="myapp"

ENV HOME=/${WORKDIR} \
  LANG=C.UTF-8 \
  TZ=Asia/Tokyo

WORKDIR ${HOME}

COPY . ./

RUN bundle install -j4

CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]