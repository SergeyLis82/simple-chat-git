#!/bin/bash

export PROJECT_DIR=$(pwd)

#nginx
export NGINX_IMG="nginx"
export NGINX_DIR="${PROJECT_DIR}/nginx"
export PORT=8080

#php-fpm
export PHP_VER="7.4"
export PHP_IMG="sergeylis82/php-fpm:${PHP_VER}"

#db
export MYSQL_VER="8.0"
export MYSQL_IMG="mysql:${MYSQL_VER}"
export MYSQL_DB="${PROJECT_DIR}/mysql/database"
export MYSQL_DATA="${PROJECT_DIR}/mysql/data"
export MYSQL_ROOT_PASSWORD="Qwerty#123"
export MYSQL_DATABASE="sandbox"
export MYSQL_USER="mysql"
export MYSQL_PASSWORD="mysql"

init() {
    if [[ -n "$1" ]]; then
		export PORT=$1;
	fi
    docker-compose -f ${PROJECT_DIR}/docker-compose.yml.tpl pull
    docker-compose -f ${PROJECT_DIR}/docker-compose.yml.tpl config > ${PROJECT_DIR}/docker-compose.yml
}

up() {
    docker-compose up -d
}

down() {
    docker-compose down
}

case $1 in
    'init') init ;;
    'up') up ;;
    'down') down ;;
    *) echo "No command" ;;
esac;