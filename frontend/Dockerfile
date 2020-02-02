FROM node:alpine AS base

LABEL maintainer="Vic Shóstak <truewebartisans@gmail.com>"

WORKDIR /frontend

FROM base AS dependencies

COPY package*.json ./
RUN npm install --only=production

FROM dependencies AS build

WORKDIR /frontend
COPY src ./
RUN npm run build:prod

FROM node:alpine AS release

WORKDIR /frontend
COPY --from=dependencies /frontend/package.json ./
RUN npm install --only=production
COPY --from=build /frontend ./
