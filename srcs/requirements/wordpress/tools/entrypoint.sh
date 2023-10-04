#!/bin/sh
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

if [ ! -d "/var/www/html/wordpress" ]; then
	mkdir -p /var/www/html
	wp core download --version=6.3.1 --path=/var/www/html/wordpress
	sed -i "s/username_here/$MDB_USER/g" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/password_here/$MDB_USER_PWD/g" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/localhost/$MDB_HOSTNAME/g" /var/www/html/wordpress/wp-config-sample.php
	sed -i "s/database_name_here/$MDB_DATABASE/g" /var/www/html/wordpress/wp-config-sample.php
	cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

	cd /var/www/html/wordpress && wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PWD" --admin_email="$WP_ADMIN_EMAIL" --skip-email

	chown nginx:nginx -R /var/www/html/*
	find /var/www/html -type d -exec chmod 777 {} \;
	find /var/www/html -type f -exec chmod 777 {} \;
fi

php-fpm8 -F
