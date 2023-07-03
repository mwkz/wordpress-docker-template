FROM wordpress:latest
RUN apt-get update && \
        apt-get install -y  --no-install-recommends ssl-cert && \
        rm -r /var/lib/apt/lists/* && \
        a2enmod ssl && \
        a2enmod headers && \
        a2ensite default-ssl


# Install Xdebug
RUN pecl install xdebug 

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy xdebug.ini into the container
#COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# FROM php:7.4-fpm

# RUN apt-get update && apt-get install

# RUN apt-get install zlib1g-dev

# RUN apt-get install -y \
#         libfreetype6-dev \
#         libjpeg62-turbo-dev \
#         libpng-dev \
#     && docker-php-ext-configure gd --with-freetype --with-jpeg \
#     && docker-php-ext-install -j$(nproc) gd

# RUN docker-php-ext-install mysqli pdo_mysql

# RUN pecl install mailparse

# RUN yes | pecl install xdebug \
#     && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
#     && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini


