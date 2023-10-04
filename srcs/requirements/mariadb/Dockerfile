FROM debian:bookworm

RUN apt update -y
RUN apt upgrade -y
RUN apt install mariadb-server tini -y

RUN mkdir -p /run/mysqld /var/lib/mysql /var/run/mysqld
RUN chown -R mysql:mysql /run/mysqld /var/lib/mysql
RUN chmod 777 /var/run/mysqld
RUN touch /var/run/mysqld/mysqld.sock

COPY ./conf/my.cnf /etc/mysql/my.cnf
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306

CMD ["tini", "--", "/entrypoint.sh"]
