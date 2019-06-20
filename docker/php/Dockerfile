FROM php:7.3-fpm-alpine

RUN echo 'http://dl-4.alpinelinux.org/alpine/edge/community/' >> /etc/apk/repositories

ENV PYTHON_VERSION=2.7.14-r2
ENV PY_PIP_VERSION=9.0.1-r1
ENV SUPERVISOR_VERSION=3.3.1

RUN apk update \
    && apk add \
        --no-cache $PHPIZE_DEPS \
        python \
        py-pip \
        libzip-dev \
        unzip \
        zip \
    && pecl install xdebug-2.7.2 \
    && docker-php-ext-enable xdebug \
    && pip install supervisor==$SUPERVISOR_VERSION

RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-install bcmath \
    ctype \
    json \
    pcntl \
    pdo_mysql \
    zip

RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

COPY ./conf/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf
# ADD docker/supervisor/supervisor.conf /etc/supervisor.conf

CMD ["php-fpm"]
# CMD ["supervisord", "-c", "/etc/supervisor.conf"]
