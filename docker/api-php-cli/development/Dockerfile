FROM php:8.2-cli-alpine3.17

RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini

RUN apk --update add wget \
  git \
  curl \
  libpq-dev \
  libpng-dev \
  libxml2-dev \
  libjpeg-turbo\
  libjpeg-turbo-dev  \
  zip \
  unzip \
  imagemagick \
  imagemagick-libs \
  imagemagick-dev \
  freetype-dev \
  freetype \
  linux-headers

RUN set -xe \
        && apk add --no-cache --virtual .build-deps \
                $PHPIZE_DEPS \
                icu-dev \
                zlib-dev \
        && pecl install \
                imagick \
        && docker-php-ext-enable imagick

RUN rm /var/cache/apk/*

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg

RUN docker-php-ext-install pdo pdo_pgsql pgsql exif pcntl bcmath gd

RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN apk add --no-cache libssh2-dev autoconf build-base
RUN pecl install ssh2-1.3.1 && docker-php-ext-enable ssh2

RUN addgroup -g 1000 app && adduser -u 1000 -G app -s /bin/sh -D app

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

WORKDIR /app

USER app
