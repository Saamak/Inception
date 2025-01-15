#!/bin/bash

echo "Démarrage du service MariaDB..."
service mariadb start

# Attente que MariaDB soit bien démarré (temps d'attente plus long)
sleep 2

# Affichage des variables d'environnement
echo "SQL_ROOT_PASSWORD=$SQL_ROOT_PASSWORD"
echo "SQL_USER=$SQL_USER"
echo "SQL_PASSWORD=$SQL_PASSWORD"
echo "SQL_DATABASE=$SQL_DATABASE"

# Création de la base de données si elle n'existe pas
echo "Création de la base de données si elle n'existe pas : ${SQL_DATABASE}..."
mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Création de l'utilisateur avec le mot de passe spécifié
echo "Création de l'utilisateur ${SQL_USER} avec le mot de passe spécifié..."
mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# Attribution des privilèges à l'utilisateur
echo "Attribution des privilèges à l'utilisateur ${SQL_USER} pour la base ${SQL_DATABASE}..."
mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Modification du mot de passe de l'utilisateur root
echo "Modification du mot de passe de l'utilisateur root..."
mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Application des changements avec FLUSH PRIVILEGES
echo "Application des changements avec FLUSH PRIVILEGES..."
mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

# Arrêt de MariaDB après la configuration initiale
echo "Arrêt du service MariaDB après configuration initiale..."
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

# Démarrage normal de MariaDB en mode sécurisé
echo "Redémarrage de MariaDB..."
exec mysqld_safe --user=mysql
