FROM debian:bullseye

# Mise à jour et installation des dépendances
RUN apt-get update && apt-get upgrade -y && \
    apt-get install mariadb-server -y

# Copie des fichiers de configuration et du script
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY script.sh /etc/tools/script.sh

# Donner les permissions d'exécution au script
RUN chmod +x /etc/tools/script.sh

EXPOSE 3306

# Exécution du script lors du démarrage du conteneur
CMD ["/etc/tools/script.sh"]
