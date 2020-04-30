FROM php:7.4.5-fpm-alpine

RUN apk update && apk add wget autoconf gcc g++ make

# Other extensions
RUN docker-php-ext-install -j$(nproc) pcntl sockets bcmath

# OpCache and APCU
RUN pecl install apcu && docker-php-ext-enable apcu         \
    && docker-php-ext-configure opcache --enable-opcache    \
    && docker-php-ext-install opcache

# Use the default production configuration for php.ini
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

#Install nginx and other tools
RUN apk update && apk add nginx netcat-openbsd          \
    && rm -rf /etc/nginx/sites-enabled/default          \
    && rm /etc/nginx/conf.d/default.conf        \
    && mkdir -p /run/nginx

# Copy files from repo
COPY ./assets/nginx.conf /etc/nginx/conf.d/nginx.conf.template
COPY ./assets/init.sh /init.sh
COPY ./assets/setup.sh /setup.sh
COPY ./assets/php-fpm.conf /usr/local/etc/php-fpm.d/zzz-overrides.conf
COPY ./assets/php.ini /usr/local/etc/php/conf.d/50-php.ini

COPY ./assets/conf /conf

#Environment vars
ENV OPCACHE_USE_PRELOAD "true"
ENV OPCACHE_PRELOAD_FILE "/app/var/cache/dev/App_KernelDevDebugContainer.preload.php"

EXPOSE 80

WORKDIR /app
CMD /init.sh