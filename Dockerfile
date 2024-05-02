FROM tonisormisson/dev-lemp:1.1.0
ENV DEBIAN_FRONTEND noninteractive

## nginx conf
COPY nginx/default /etc/nginx/sites-available/default

## copy limesurvey
RUN rm -rf /var/www/html/*
ADD html/ /var/www/html
RUN rm -rf /var/www/html/.git

# set lime permissions
RUN cd /var/www/html/ && chown -R 1000:www-data tmp
RUN cd /var/www/html/ && chown -R 1000:www-data upload
RUN cd /var/www/html/ && chown -R 1000:www-data tests/tmp


# install Limesurvey
RUN cd /var/www/html/ && composer install
RUN cd /var/www/html/ && cp application/config/config-sample-mysql.php application/config/config.php
RUN cd /var/www/html/ && sed -i "s/'debug'=>0,/'debug'=>2,'maxLoginAttempt' => 999999999,/"  application/config/config.php
RUN cd /var/www/html/ && cat application/config/config.php

RUN cd /var/www/html/ && chmod -R 775 tmp
RUN cd /var/www/html/ && chmod -R 775 upload
RUN cd /var/www/html/ && chmod -R 775 tests/tmp


## enable json RPC
RUN cd /var/www/html/ && sed -i "/Update default LimeSurvey config here/a \ \ \ \ \ \ \ \ 'RPCInterface' => 'json', " application/config/config.php
RUN service mariadb start && cd /var/www/html/ && DBENGINE=MYISAM php application/commands/console.php install admin password TravisLS no@email.com verbose


# Expose Ports
EXPOSE 443
EXPOSE 80
EXPOSE 3306
COPY start.sh /start.sh
RUN chmod a+x /start.sh
RUN ls -lst

## cleanup of files from setup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/html

CMD sh /start.sh
ENV DEBIAN_FRONTEND teletype
