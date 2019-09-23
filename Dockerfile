FROM php:7.2-fpm


# To Add Composer to auto install

# RUN apt-get update -y && apt-get install -y openssl zip unzip git
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#  Add the following line after the Copy of /var/www
#  RUN composer install

# Set working directory
WORKDIR /var/www

RUN docker-php-ext-install pdo mbstring pdo_mysql

# Copy existing application directory contents
COPY . /var/www

#  If using composer above uncomment out the following
#  RUN composer install

# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]


# if we wanted to use php as a web serv rather than nginX
#  CMD php artisan serve --host=0.0.0.0 --port=8080
#  EXPOSE 8080

