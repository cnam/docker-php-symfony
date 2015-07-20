FROM alpine:3.2

EXPOSE 9000

RUN apk --update \
	 add php-fpm \
	 php-mcrypt \
         php-json \
         php-curl \
	 php-opcache \
         php-mysql \
         php-pdo \
         php-intl \
	 php-ctype \
	 php-xml \
         php-dom \
         php-openssl \
	 php-pdo_mysql

RUN sed -i 's/\;date\.timezone\ \=/date\.timezone\ \=\ Europe\/Moscow/g' /etc/php/php.ini \
    && sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php/php-fpm.conf \
    && sed -i 's/listen.allowed_clients = 127.0.0.1/;listen.allowed_clients = 127.0.0.1/g' /etc/php/php-fpm.conf

COPY . /var/www/backend
WORKDIR /var/www/backend


CMD ["php-fpm", "-F"]

