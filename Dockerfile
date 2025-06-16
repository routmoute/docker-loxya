ARG ARCH=
ARG PHP_VERSION=8.3
ARG LOXYA_VERSION=1.1.2

FROM ${ARCH}php:${PHP_VERSION}-apache
RUN apt update && apt -y upgrade && \
    apt -y install unzip wget libicu-dev libfreetype-dev libjpeg62-turbo-dev libpng-dev && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# PREPARE PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) bcmath gettext intl pdo_mysql gd
#RUN mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini
RUN a2enmod rewrite

# DOWNLOAD AND INSTALL LOXYA
ARG LOXYA_VERSION
RUN cd / && \
    wget https://github.com/Robert-2/Robert2/releases/download/${LOXYA_VERSION}/Loxya-${LOXYA_VERSION}.zip && \
    unzip Loxya-${LOXYA_VERSION}.zip && \
    rm Loxya-${LOXYA_VERSION}.zip && \
    rm -r /var/www/html && \
    mv Loxya-${LOXYA_VERSION} /var/www/html && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html/data /var/www/html/src/var/cache /var/www/html/src/var/logs /var/www/html/src/var/tmp /var/www/html/src/App/Config

EXPOSE 80
