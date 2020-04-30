#! /bin/sh

/setup.sh

set -o pipefail
echo "Starting php-fpm"
php-fpm -D

echo "Starting nginx"
exec nginx -g 'daemon off;'

