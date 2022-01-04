FROM ruby:3.0

ARG WORKDIR

ENV HOME=/${WORKDIR} \
  LANG=C.UTF-8 \
  TZ=Asia/Tokyo

WORKDIR ${HOME}

COPY . ./

RUN /bin/sh -c "bundle install -j4"
