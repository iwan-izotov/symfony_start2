#!/bin/bash

# Install dependencies
apt-get update -y && apt-get install -y \
    apt-utils \
    g++ \
    build-essential \
    libbz2-dev \
    libonig-dev \
    libedit-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmagickwand-dev \
    libmemcached-dev \
    libssl-dev \
    libreadline-dev \
    libzip-dev \
    libpng-dev \
    libcurl3-dev \
    locales \
    wget \
    unzip \
    zlib1g-dev \
    vim \
    git \
    mc \
    nano \
    mariadb-client \
    openssl \
    zip \
    curl \
    librabbitmq-dev \
    libssh-dev \
    libpq-dev \
    libxslt-dev \
    ssh \
    libssh2-1-dev \
    libssh2-1

# Install extensions
docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) gd \
  && docker-php-ext-configure intl \
  && docker-php-ext-install -j$(nproc) intl \
  && docker-php-ext-install -j$(nproc) \
     bcmath \
     bz2 \
     calendar \
     exif \
     pdo_pgsql \
     xsl \
     gettext \
     mysqli \
     opcache \
     pdo_mysql \
     soap \
     sockets \
     curl \
     xml \
     exif \
     pcntl \
     mbstring \
  && docker-php-ext-configure zip && docker-php-ext-install zip \
  && pecl install xdebug-3.0.3 && docker-php-ext-enable xdebug \
  && pecl install -o -f redis &&  rm -rf /tmp/pear &&  docker-php-ext-enable redis