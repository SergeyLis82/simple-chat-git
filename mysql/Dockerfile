FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=Qwerty#123
ENV MYSQL_DATABASE=sandbox
ENV MYSQL_USER=mysql
ENV MYSQL_PASSWORD=mysql

RUN mysql -u root -e "GRANT SELECT,UPDATE,INSERT ON sandbox.* TO 'mysql'@'localhost';"\
   && mysql -u root -e "CREATE TABLE IF NOT EXISTS `chat` (\
  `id` int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY, \
  `name` varchar(32) NOT NULL, \
  `message` varchar(255) NOT NULL, \
  `created_at` int unsigned NOT NULL \
) ENGINE='InnoDB';"

ENTRYPOINT [ "/usr/sbin/mysqld" ]