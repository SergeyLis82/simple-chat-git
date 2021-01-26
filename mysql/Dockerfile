FROM mysql:5.7

EXPOSE 3306

COPY ./data /tmp/mysql

WORKDIR /tmp/mysql

RUN /bin/bash -c "/tmp/mysql/init_db.sh"

ENTRYPOINT [ "/etc/init.d/mysql", "start" ]