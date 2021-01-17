#!/bin/bash

DATA=`date +"%Y-%m-%d_%H-%M"`
PATHB=/mnt/backups

docker exec mysql /usr/bin/mysqldump -u mysql --password=mysql sandbox > "$PATHB"/"$DATA"-sandbox.sql

/bin/gzip "$PATHB"/"$DATA"-sandbox.sql

/usr/bin/find "$PATHB" -type f -mtime +1 -exec rm -rf {} \;
