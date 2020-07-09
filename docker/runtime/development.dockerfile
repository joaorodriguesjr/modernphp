FROM php:7.4.7-fpm-alpine3.12 AS base
WORKDIR /var/www
COPY application /var/www
COPY docker/runtime/general.ini /usr/local/etc/php/conf.d/general.ini


FROM composer:1.10.8 AS build
COPY application /application
WORKDIR /application


FROM build AS development_build
RUN composer install -vvv


FROM base AS debug
RUN apk add --no-cache $PHPIZE_DEPS
RUN pecl install xdebug-2.9.6
RUN docker-php-ext-enable xdebug
RUN apk del --purge $PHPIZE_DEPS
COPY docker/runtime/debug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini


FROM debug AS development
RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
RUN rm /usr/local/etc/php/php.ini-production
COPY --from=development_build /application/vendor /var/www/vendor
