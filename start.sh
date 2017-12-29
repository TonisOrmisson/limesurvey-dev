#!/bin/bash

# Start mysql
echo "Starting mysql "
find /var/lib/mysql -type f -exec touch {} \; && service mysql start
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start mysql: $status"
  exit $status
fi

# Start PHP-fpm
echo "Starting PHP-fpm "
service php7.0-fpm start
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start PHP-fpm: $status"
  exit $status
fi

# Start selenium
echo "Starting Selenium ... "
export MOZ_HEADLESS=1 && java -jar selenium-server-standalone-3.7.1.jar -enablePassThrough false > /dev/null 2> /dev/null &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start Selenium: $status"
  exit $status
fi

# Start nginx
echo "Starting nginx .... "
nginx -g "daemon off;"
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start nginx: $status"
  exit $status
fi

