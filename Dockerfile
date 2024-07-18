FROM php:8.3-fpm-alpine AS base

LABEL maintainer="MilesChou <github.com/MilesChou>, fizzka <github.com/fizzka>"

ARG PHALCON_VERSION=5.8.0

WORKDIR /

RUN set -xe && \
        apk add --no-cache --virtual .build-deps \
            autoconf \
            g++ \
            make \
        && \
        docker-php-source extract && \
        # Install ext-phalcon
        curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
        tar xzf /v${PHALCON_VERSION}.tar.gz && \
        docker-php-ext-install -j $(getconf _NPROCESSORS_ONLN) \
            /cphalcon-${PHALCON_VERSION}/build/phalcon \
        && \
        # Remove all temp files
        rm -r \
            /v${PHALCON_VERSION}.tar.gz \
            /cphalcon-${PHALCON_VERSION} \
        && \
        docker-php-source delete && \
        apk del .build-deps && \
        php -m

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
RUN composer global require phalcon/devtools

#COPY docker-phalcon-* /usr/local/bin/

FROM base

RUN apk --no-cache add icu-dev $PHPIZE_DEPS libxpm-dev freetype-dev libjpeg-turbo-dev libpng-dev libwebp-dev imagemagick-dev imagemagick bzip2-dev tidyhtml-dev libzip-dev \
    && docker-php-ext-install pdo_mysql intl opcache gd exif bz2 tidy zip \
    && ln -s  /usr/local/include/php/ext/standard/php_smart_string.h /usr/local/include/php/ext/standard/php_smart_str.h \
    && pecl channel-update pecl.php.net
RUN apk add --update linux-headers
RUN pecl install xdebug apcu imagick \
    && docker-php-ext-enable xdebug apcu imagick \
    && apk del --no-cache $PHPIZE_DEPS \
    && rm -rf /var/cache/apk/*
