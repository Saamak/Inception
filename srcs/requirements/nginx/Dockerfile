FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl /var/run/nginx /etc/nginx/snippets /var/www/html

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=France/L=Angouleme/O=Ecole42/OU=42/CN=ppitzini.42.fr"

RUN chmod 755 /var/www/html && \
    chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]