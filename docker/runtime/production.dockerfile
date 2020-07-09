FROM php:7.4.7-fpm-alpine3.12 AS base
WORKDIR /var/www
COPY application /var/www
COPY docker/runtime/general.ini /usr/local/etc/php/conf.d/general.ini


FROM composer:1.10.8 AS build
COPY application /application
WORKDIR /application


FROM build AS production_build
RUN composer install -vvv --no-dev --optimize-autoloader


FROM base AS production
RUN docker-php-ext-configure opcache --enable-opcache && docker-php-ext-install opcache
RUN mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini
RUN rm /usr/local/etc/php/php.ini-development
COPY docker/runtime/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY --from=production_build /application/vendor /var/www/vendor
RUN rm composer.json
