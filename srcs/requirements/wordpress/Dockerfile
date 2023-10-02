FROM debian:bookworm

RUN apt update -y
RUN apt upgrade -y
RUN apt install \
	tini \
	wget \
	unzip \
	php \
    php-curl \
    php-fpm \
    php-bcmath \
    php-gd \
    php-soap \
    php-zip  \
    php-mbstring \
    php-mysqlnd \
    php-gd \
    php-xml \
    php-intl \
    php-zip \
    -y

RUN wget https://wordpress.org/latest.zip && unzip latest.zip -d /var/www/html/
RUN cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
RUN rm -rf latest.zip

COPY ./tools/entrypoint.sh /entrypoint.sh
COPY ./conf/www.conf /etc/php/*/fpm/pool.d/
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/html/wordpress

EXPOSE 9000

ENTRYPOINT ["tini", "--", "/entrypoint.sh"]
