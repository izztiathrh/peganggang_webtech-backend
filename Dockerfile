# Use official PHP image with Apache
FROM php:8.1-apache

# Install necessary PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install PostgreSQL extension for Render
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo_pgsql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy application files
COPY . /var/www/html/

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port 80 (Render will map this)
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]