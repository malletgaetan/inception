#!/usr/bin/env bash
set -e

if [ -z "${MDB_HOSTNAME}" ]; then
	echo "MDB_HOSTNAME env var not set."
	exit 1
fi

if [ -z "${MDB_DATABASE}" ]; then
	echo "MDB_DATABASE env var not set."
	exit 1
fi

if [ -z "${MDB_USER}" ]; then
	echo "MDB_USER env var not set."
	exit 1
fi

if [ -z "${MDB_USER_PWD}" ]; then
	echo "MDB_USER_PWD env var not set."
	exit 1
fi

sed -i "s/username_here/$MDB_USER/g" wp-config-sample.php
sed -i "s/password_here/$MDB_USER_PWD/g" wp-config-sample.php
sed -i "s/localhost/$MDB_HOSTNAME/g" wp-config-sample.php
sed -i "s/database_name_here/$MDB_DATABASE/g" wp-config-sample.php
cp wp-config-sample.php wp-config.php

chown nginx:nginx -R /var/www/html/*
find /var/www/html -type d -exec chmod 777 {} \;
find /var/www/html -type f -exec chmod 777 {} \;

php-fpm8.2 -F
