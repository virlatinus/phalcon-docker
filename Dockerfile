FROM mileschou/phalcon:7.4-fpm-alpine

# Necessary for phalcon-tools to manage models and DB tasks
RUN docker-php-ext-install pdo_mysql

# Add i118n support
RUN apk --no-cache add icu-dev \
    && docker-php-ext-install intl

# Add xdebug support
RUN apk add --no-cache $PHPIZE_DEPS \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apk del --no-cache $PHPIZE_DEPS \
    && rm -rf /var/cache/apk/*
