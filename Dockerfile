FROM ubuntu:xenial
RUN apt update
RUN apt install -y nginx
RUN apt install nano
# Install MySQL
RUN echo mysql-server mysql-server/root_password password root | debconf-set-selections;\
    echo mysql-server mysql-server/root_password_again password root | debconf-set-selections;\
    apt-get install -y mysql-server mysql-client libmysqlclient-dev

# start mysql
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
RUN find /var/lib/mysql -type f -exec touch {} \; && service mysql start && mysql -uroot -proot


# install php
RUN apt-get install -y php-fpm php-mysql
COPY nginx/default /etc/nginx/sites-available/default
RUN service php7.0-fpm start

RUN service nginx restart


# install composer
RUN apt-get install -y curl php-cli php-mbstring git unzip
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN composer

## copy limesurvey
RUN rm -rf /var/www/html/*
COPY html/* /var/www/html/


# set lime permissions
ARG INCUBATOR_VER=unknown5
RUN cd /var/www/html/ && mkdir tmp/runtime && chmod -R 777 tmp
RUN cd /var/www/html/ && chmod -R 777 upload
RUN cd /var/www/html/ && mkdir tests/tmp && chmod -R 777 tests/tmp

# install Limesurvey
RUN php application/commands/console.php install admin password TravisLS no@email.com verbose
EXPOSE 3306


# first n is for validate password plugin removal and it could be y

# Expose Ports
EXPOSE 443
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]