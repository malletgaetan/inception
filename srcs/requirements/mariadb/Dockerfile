FROM debian:bookworm

RUN apt update -y
RUN apt upgrade -y
RUN apt install mariadb-server -y

COPY ./conf/setup.sh /setup.sh

#ENTRYPOINT ["bash", "setup.sh"]
EXPOSE 3306
CMD ["mariadbd-safe", "&&", "bash", "setup.sh"]
