FROM ubuntu:xenial
RUN apt update --fix-missing
RUN apt install -y nginx
RUN apt install nano

# Install MySQL
RUN echo mysql-server mysql-server/root_password password root | debconf-set-selections;\
    echo mysql-server mysql-server/root_password_again password root | debconf-set-selections;\
    apt-get install -y mysql-server mysql-client libmysqlclient-dev


# install php
RUN apt-get install -y php-fpm php-mysql php-curl php-gd php-imap php-zip php-ldap php-xml


# start mysql
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
RUN find /var/lib/mysql -type f -exec touch {} \; && service mysql start

## nginx conf
COPY nginx/default /etc/nginx/sites-available/default


# start things
RUN service php7.0-fpm start
RUN service nginx restart

# install composer
RUN apt-get install -y curl php-cli php-mbstring git unzip
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN composer

## copy limesurvey
RUN rm -rf /var/www/html/*
ADD html/ /var/www/html/


# set lime permissions
RUN cd /var/www/html/ && chmod -R 777 tmp
RUN cd /var/www/html/ && chmod -R 777 upload
RUN cd /var/www/html/ && chmod -R 777 tests/tmp

# install Limesurvey
RUN cd /var/www/html/ && composer install
RUN cd /var/www/html/ && cp application/config/config-sample-mysql.php application/config/config.php
RUN cd /var/www/html/ && sed -i "s/'password' => ''/'password' => 'root'/"  application/config/config.php
RUN cd /var/www/html/ && sed -i "s/'debug'=>0/'debug'=>2/"  application/config/config.php
## enable json RPC
RUN cd /var/www/html/ && sed -i "/Update default LimeSurvey config here/a \ \ \ \ \ \ \ \ 'RPCInterface' => 'json'," application/config/config.php
RUN service mysql start && cd /var/www/html/ && php application/commands/console.php install admin password TravisLS no@email.com verbose

# install phpunit
RUN apt-get install -y wget

RUN wget https://phar.phpunit.de/phpunit-6.5.phar
RUN chmod +x phpunit-6.5.phar
RUN mv phpunit-6.5.phar /usr/local/bin/phpunit
RUN phpunit --version

# install firefox for tests
RUN apt-get -y install  --fix-missing nodejs firefox
RUN firefox -v
RUN ln -s /usr/bin/nodejs /usr/bin/node

# get selenium for testing
RUN wget "https://selenium-release.storage.googleapis.com/3.7/selenium-server-standalone-3.7.1.jar"
RUN wget "https://github.com/mozilla/geckodriver/releases/download/v0.19.1/geckodriver-v0.19.1-linux64.tar.gz"
RUN tar xvzf geckodriver-v0.19.1-linux64.tar.gz
RUN apt-get install -y default-jre

# Expose Ports
EXPOSE 443
EXPOSE 80
COPY start.sh start.sh
RUN chmod a+x start.sh

CMD ./start.sh