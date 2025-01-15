#!/bin/bash

# Add logging
echo "[INFO] Starting WordPress configuration..."

# Create PHP-FPM run directory if not exists
mkdir -p /run/php

# Wait for MariaDB to be ready
echo "[INFO] Waiting for MariaDB..."
sleep 10

cd /var/www/wordpress

# Remove existing wp-config.php if it exists
if [ -f wp-config.php ]; then
    echo "[INFO] Removing existing wp-config.php..."
    rm wp-config.php
fi

# Create wp-config.php
echo "[INFO] Creating wp-config.php..."
wp config create --allow-root \
    --dbname=$SQL_DATABASE \
    --dbuser=$SQL_USER \
    --dbpass=$SQL_PASSWORD \
    --dbhost=mariadb:3306 \
    --path='/var/www/wordpress'

wp core install --allow-root --url="ppitzini.42.fr" --title="yaourt" --admin_user=$WP_ADMIN_LOGIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --path='/var/www/wordpress'
wp user create --allow-root $WP_USER_LOGIN $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=subscriber
chmod -R 775 wp-content
echo "wp-config.php done"

# Start PHP-FPM
echo "[INFO] Starting PHP-FPM..."
service php7.4-fpm start

# Start Nginx
echo "[INFO] Starting Nginx..."
nginx -g 'daemon off;'