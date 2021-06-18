FROM php:8.0.7-fpm

# Surpresses debconf complaints of trying to install apt packages interactively
# https://github.com/moby/moby/issues/4032#issuecomment-192327844
ARG DEBIAN_FRONTEND=noninteractiv

# Копируем общие скрипты
COPY ./shared/ /tmp/scripts/
RUN chmod +x -R /tmp/scripts/

# копирование php.ini
COPY ./php/config/php.ini /usr/local/etc/php/php.ini

# Копируем общие скрипты для php-контейнеров
COPY ./php/scripts/ /tmp/php_scripts/
RUN chmod +x -R /tmp/php_scripts/

# Установка TIMEZONE
ARG TIMEZONE
RUN /tmp/scripts/install_timezone.sh ${TIMEZONE}

RUN apt-get update -y && apt-get upgrade -y

# Устанавливаем полезные утилиты
RUN /tmp/scripts/install_software.sh

# Устанавливаем php extensions
RUN /tmp/php_scripts/install_extensions.sh

# Устанавливаем composer
RUN /tmp/php_scripts/install_composer.sh

# Устанавливаем symfony
RUN /tmp/php_scripts/install_symfony.sh

ARG XDEBUG_REMOTE_HOST
ARG XDEBUG_REMOTE_PORT
RUN /tmp/php_scripts/setting_xdebug.sh ${XDEBUG_REMOTE_HOST} ${XDEBUG_REMOTE_PORT}

# Очистка
RUN /tmp/php_scripts/cleanup.sh

# Устанавливаем рабочую дерикторию
WORKDIR /var/www/symfony_start

# Устанавливаем подстветку bash
COPY ./shared/.bashrc /root/.bashrc

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]