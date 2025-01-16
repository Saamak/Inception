#!/bin/sh


if [ ! -d "/var/lib/mysql/$SQL_DATABASE" ]; then

    echo "The database ${SQL_DATABASE} does not exist. Configuring..."

    mysqld_safe --datadir='/var/lib/mysql' &

    sleep 10

    # Créer la base de données si elle n'existe pas déjà
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

    # Créer un utilisateur et lui attribuer un mot de passe
    mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

    # Accorder tous les privilèges sur la base de données à l'utilisateur
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%' WITH GRANT OPTION;"

    # Modifier le mot de passe de l'utilisateur root
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

    # Rafraîchir les privilèges pour prendre en compte les modifications
    mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

    # Arrêter MariaDB après la configuration
    mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

    echo "SQL config done"

else  
    echo "Database already created"
fi

# Redémarrer MariaDB normalement
exec mariadbd