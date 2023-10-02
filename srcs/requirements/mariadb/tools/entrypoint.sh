#!/usr/bin/env bash
set -e

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

if [ -z "${MDB_ROOT_PWD}" ]; then
	echo "MDB_ROOT_PWD env var not set."
	exit 1
fi

if [ -z "${MDB_ADMIN}" ]; then
	echo "MDB_ADMIN env var not set."
	exit 1
fi

if [ -z "${MDB_ADMIN_PWD}" ]; then
	echo "MDB_ADMIN_PWD env var not set."
	exit 1
fi

echo "CREATE DATABASE IF NOT EXISTS $MDB_DATABASE ;" > init.sql
echo "CREATE USER IF NOT EXISTS '$MDB_USER'@'%' IDENTIFIED BY '$MDB_USER_PASSWORD' ;" >> init.sql
echo "CREATE USER IF NOT EXISTS '$MDB_ADMIN_USER'@'%' IDENTIFIED BY '$MDB_ADMIN_PASSWORD';" >> init.sql
echo "GRANT ALL PRIVILEGES ON $MDB_DATABASE.* TO '$MDB_USER'@'%' ;" >> init.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MDB_ROOT_PASSWORD' ;" >> init.sql
echo "GRANT ALL ON $MDB_DATABASE.* TO '$MDB_ADMIN_USER'@'%' IDENTIFIED BY '$MDB_ADMIN_PASSWORD' WITH GRANT OPTION;" >> init.sql
echo "GRANT SELECT, CREATE, INSERT, UPDATE, DELETE ON $MDB_DATABASE.* TO '$MDB_USER'@'%' IDENTIFIED BY '$MDB_USER_PASSWORD';" >> init.sql
echo "FLUSH PRIVILEGES ;" >> init.sql

mariadbd
