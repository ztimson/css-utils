# Build application
FROM node:alpine as build

RUN mkdir /app
WORKDIR /app
COPY . .
RUN if [ ! -d "node_modules" ]; then npm i; fi && \
    if [ ! -d "dist/css-utils.css" ]; then npm run build; fi

# Use Nginx to serve
FROM nginx:1.23-alpine

COPY --from=build /app/dist /usr/share/nginx/html/dist
COPY src /usr/share/nginx/html/src
COPY index.html /usr/share/nginx/html
COPY wave.webp /usr/share/nginx/html
COPY favicon.webp /usr/share/nginx/html
