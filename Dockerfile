FROM php:7.1-fpm-alpine

RUN apk update && apk add build-base

RUN apk add zlib-dev git zip \
   && docker-php-ext-install zip

RUN curl -sS https://getcomposer.org/installer | php \
        && mv composer.phar /usr/local/bin/ \
        && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

COPY public_html /app
WORKDIR /app

RUN composer install --prefer-source --no-interaction

ENV PATH="~/.composer/vendor/bin:./vendor/bin:${PATH}"
