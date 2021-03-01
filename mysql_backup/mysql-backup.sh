#!/bin/bash

DATA=`date +"%Y-%m-%d_%H-%M"`
PATHB=/mnt/backups

mysqldump -u root --password=Qwerty#123 sandbox | gzip > "$PATHB"/"$DATA"-sandbox.sql.gz

#/bin/gzip "$PATHB"/"$DATA"-sandbox.sql

/usr/bin/find "$PATHB" -type f -mtime +1 -exec rm -rf {} \;
