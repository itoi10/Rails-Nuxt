FROM ruby:2.7.5

ARG WORKDIR

ENV HOME=/${WORKDIR} \
  LANG=C.UTF-8 \
  TZ=Asia/Tokyo

WORKDIR ${HOME}

COPY . ./

RUN /bin/sh -c "bundle install -j4"
