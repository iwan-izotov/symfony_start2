#!/bin/bash

XDEBUG_REMOTE_HOST=$1
XDEBUG_REMOTE_PORT=$2

# подменяем в php.ini __XDEBUG_REMOTE_HOST и __XDEBUG_REMOTE_PORT на значения из окружения
sed -i -e "s#__XDEBUG_REMOTE_HOST#$XDEBUG_REMOTE_HOST#" "/usr/local/etc/php/php.ini" \
 && sed -i -e "s#__XDEBUG_REMOTE_PORT#$XDEBUG_REMOTE_PORT#" "/usr/local/etc/php/php.ini"