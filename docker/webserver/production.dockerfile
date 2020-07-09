FROM nginx:1.19.0-alpine AS production
COPY docker/webserver/default.conf /etc/nginx/conf.d/default.conf
