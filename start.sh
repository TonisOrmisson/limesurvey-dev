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


# Start nginx
echo "Starting nginx .... "
nginx -g "daemon off;"
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start nginx: $status"
  exit $status
fi

