FROM php:8.1-cli
RUN apt-get update && apt-get install -y unzip git
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
WORKDIR /app
COPY . /app
RUN composer install
CMD ["php", "-S", "0.0.0.0:8000", "-t", "."]
