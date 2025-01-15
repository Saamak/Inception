#!/bin/bash

# Variables
DOCKER_IMAGE=mariadb:latest  # Image Docker de MariaDB
CONTAINER_NAME=mariadb-container  # Nom du conteneur
MYSQL_ROOT_PASSWORD=Inception42  # Mot de passe root
MYSQL_USER=Dani  # Nom de l'utilisateur
MYSQL_PASSWORD=Inception42  # Mot de passe de l'utilisateur
MYSQL_DATABASE=DANIDOU  # Base de données

# Fonction pour construire et lancer le conteneur MariaDB
start_container() {
    echo "Lancement du conteneur MariaDB..."

    # Vérifier si le conteneur existe déjà et le supprimer si nécessaire
    if [ $(docker ps -aq -f name=$CONTAINER_NAME) ]; then
        echo "Le conteneur existe déjà. Arrêt et suppression en cours..."
        docker stop $CONTAINER_NAME
        docker rm $CONTAINER_NAME
    fi

    # Construire et lancer le conteneur
    docker run --name $CONTAINER_NAME -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -e MYSQL_USER=$MYSQL_USER -e MYSQL_PASSWORD=$MYSQL_PASSWORD -e MYSQL_DATABASE=$MYSQL_DATABASE -d $DOCKER_IMAGE

    echo "Conteneur MariaDB lancé avec succès."
}

# Fonction pour ouvrir un terminal interactif dans le conteneur
open_terminal() {
    echo "Connexion au conteneur MariaDB..."

    # Lancer un terminal interactif bash dans le conteneur
    docker exec -it $CONTAINER_NAME bash
}

# Main script
start_container
open_terminal
