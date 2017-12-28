FROM ubuntu:xenial
RUN apt update
RUN apt install -y nginx
RUN apt install nano
# Install MySQL
RUN echo mysql-server mysql-server/root_password password root | debconf-set-selections;\
    echo mysql-server mysql-server/root_password_again password root | debconf-set-selections;\
    apt-get install -y mysql-server mysql-client libmysqlclient-dev

RUN apt-get install -y php-fpm php-mysql
COPY nginx/default /etc/nginx/sites-available/default
RUN service nginx restart

RUN apt-get install -y git
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
RUN find /var/lib/mysql -type f -exec touch {} \; && service mysql start && mysql -uroot -proot

RUN rm -rf /var/www/html
RUN cd /var/www/ && git clone https://github.com/LimeSurvey/LimeSurvey.git html

# install composer
RUN apt-get install -y curl php-cli php-mbstring git unzip
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN composer



ARG INCUBATOR_VER=unknown5

EXPOSE 3306


# first n is for validate password plugin removal and it could be y

# Expose Ports
EXPOSE 443
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]