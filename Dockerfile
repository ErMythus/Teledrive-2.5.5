FROM node:18.16.1 as build
ARG REACT_APP_TG_API_ID
ARG REACT_APP_TG_API_HASH

WORKDIR /apps

COPY yarn.lock .
COPY package.json .
COPY api/package.json api/package.json
COPY web/package.json web/package.json
COPY docker/.env .
RUN yarn cache clean
RUN yarn install
RUN yarn global add prisma
RUN npx browserslist@latest --update-db
COPY . .
RUN export NODE_OPTIONS="--openssl-legacy-provider --no-experimental-fetch"
RUN yarn workspaces run build
