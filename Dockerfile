FROM mileschou/phalcon:7.4-fpm-alpine

RUN apk --no-cache add icu-dev $PHPIZE_DEPS libxpm-dev freetype-dev libjpeg-turbo-dev libpng-dev libwebp-dev imagemagick-dev imagemagick bzip2-dev tidyhtml-dev libzip-dev \
    && docker-php-ext-install pdo_mysql intl opcache gd exif bz2 tidy zip \
    && ln -s  /usr/local/include/php/ext/standard/php_smart_string.h /usr/local/include/php/ext/standard/php_smart_str.h \
    && pecl channel-update pecl.php.net \
    && pecl install xdebug apcu imagick \
    && docker-php-ext-enable xdebug apcu imagick \
    && apk del --no-cache $PHPIZE_DEPS \
    && rm -rf /var/cache/apk/*
