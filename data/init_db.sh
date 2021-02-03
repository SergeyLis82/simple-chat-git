#!/bin/bash

/etc/init.d/mysql start
sleep 10
mysql -u root -e "CREATE DATABASE sandbox"
mysql -u root sandbox < /tmp/mysql/sandbox.sql