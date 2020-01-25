FROM node:alpine

LABEL maintainer="Vic Shóstak <truewebartisans@gmail.com>"

WORKDIR /frontend
COPY ["package*.json", "src", "./"]
RUN npm i -s && npm run build:prod
