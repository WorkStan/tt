FROM nginx:1.21-alpine

COPY ./development/conf.d /etc/nginx/conf.d

COPY ./development/includes /etc/nginx/includes

RUN chmod +x /etc/nginx/includes/cloudflare.sh

WORKDIR /app
