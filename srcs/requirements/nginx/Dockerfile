FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y nginx openssl tini

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \ 
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=LeHavre/L=LeHavre/O=42/OU=42/CN=gmallet.42.fr/"


COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/log/nginx
RUN mkdir -p /var/www/html
RUN chmod 755 /var/www/html
# RUN chown -R www-data:www-data /var/www/html

ENTRYPOINT ["tini", "--"]

CMD [ "nginx", "-g", "daemon off;" ]
