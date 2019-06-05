FROM php:7.3-fpm-alpine

RUN apk update \
    && apk add \
        --no-cache $PHPIZE_DEPS \
        libzip-dev \
        unzip \
        zip \
    && pecl install xdebug-2.7.2 \
    && docker-php-ext-enable xdebug

RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-install mbstring pdo_mysql zip pcntl bcmath

RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

COPY ./conf/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf

CMD ["php-fpm"]
