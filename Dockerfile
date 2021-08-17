FROM alpine:3.14

# Install packages and remove default server definition
RUN apk --no-cache add \
  tzdata \
  curl \
  nginx \
  runit \
  php8 \
  php8-ctype \
  php8-curl \
  php8-dom \
  php8-fpm \
  php8-gd \
  php8-intl \
  php8-json \
  php8-mbstring \
  php8-mysqli \
  php8-opcache \
  php8-openssl \
  php8-phar \
  php8-session \
  php8-xml \
  php8-xmlreader \
  php8-zlib

RUN rm /etc/nginx/http.d/default.conf

# Create symlink so programs depending on `php` still function
RUN ln -s /usr/bin/php8 /usr/bin/php

COPY etc/ /etc/

RUN rm -rf /var/www && mkdir -p /var/www/html && chown -R nobody:nobody /var/www/html

WORKDIR /var/www/html

EXPOSE 80

ENTRYPOINT runsvdir /etc/service
