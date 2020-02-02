FROM node:alpine AS build-stage

LABEL maintainer="Vic Shóstak <truewebartisans@gmail.com>"

WORKDIR /frontend
COPY package*.json ./
RUN npm install --only=production
COPY . .
RUN npm run build:prod

FROM nginx:alpine AS production-stage

COPY --from=build-stage /frontend/build/ /usr/share/nginx/html
