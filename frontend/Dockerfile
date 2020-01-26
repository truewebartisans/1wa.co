FROM node:alpine as builder

LABEL maintainer="Vic Shóstak <truewebartisans@gmail.com>"

WORKDIR /frontend
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build:prod

FROM nginx:alpine

COPY --from=builder /frontend/build /usr/share/nginx/html/
