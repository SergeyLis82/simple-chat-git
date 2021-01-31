version: '3.7'

services:
    nginx:
        image: nginx
        ports:
            - "${PORT}:80"

        volumes:
            - ${NGINX_DIR}/core:/etc/nginx/conf.d
            - ${NGINX_DIR}/www/simple-chat:/var/www
            - ${NGINX_DIR}/Logs:/var/log/nginx/

        depends_on:
            - php-fpm
            
    php-fpm:
        image: ${PHP_IMG}
        volumes:
            - ${NGINX_DIR}/www/simple-chat:/var/www

        depends_on:
            - mysql

    mysql:
        image: mysql:8.0
        volumes:
            - "${MYSQL_DB}:/var/lib/mysql:rw"
            - "${MYSQL_DATA}:/docker-entrypoint-initdb.d:rw"

        environment:
            - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
            - MYSQL_DATABASE=${MYSQL_DATABASE}
            - MYSQL_USER=${MYSQL_USER}
            - MYSQL_PASSWORD=${MYSQL_PASSWORD}
            - TZ="Europe/Moscow"
        restart: always
    
    adminer:
        image: adminer
        restart: always
        ports: 
         - 8081:8080