FROM node:17.3.0-alpine

ARG WORKDIR
ARG API_URL

ENV HOME=/${WORKDIR} \
  LANG=C.UTF-8 \
  TZ=Asia/Tokyo \
  HOST=0.0.0.0 \
  NODE_OPTIONS=--openssl-legacy-provider \
  API_URL=${API_URL}

WORKDIR ${HOME}

# package install
COPY . ./
RUN yarn install

# nuxt build
RUN yarn run build