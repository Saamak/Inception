FROM debian:bullseye

# Mise à jour et installation des dépendances
RUN apt-get update && apt-get upgrade -y && apt-get -y install wget

# Installer PHP 7.4, l'extension MySQL et le client MariaDB
RUN apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client \
    nginx \
    curl

# Télécharger et extraire WordPress
RUN wget https://fr.wordpress.org/wordpress-6.6-fr_FR.tar.gz -P /var/www
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN cd /var/www && tar -xzf wordpress-6.6-fr_FR.tar.gz && rm wordpress-6.6-fr_FR.tar.gz

# Modifier les permissions des fichiers WordPress
RUN chown -R www-data:www-data /var/www/wordpress
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Copier le fichier de configuration Nginx
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY auto_config.sh /etc/tools/auto_config.sh
# RUN chmod +x /etc/tools/auto_config.sh
RUN chmod a+x /etc/tools/auto_config.sh

# Exposer les ports nécessaires pour HTTP (80) et PHP-FPM (9000)
EXPOSE 80 9000

# Lancer les services PHP-FPM et Nginx
CMD ["/etc/tools/auto_config.sh"]



