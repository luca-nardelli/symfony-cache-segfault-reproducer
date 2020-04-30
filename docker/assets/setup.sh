#! /bin/sh

# Fixing file permissions!
# http://symfony.com/doc/current/setup/file_permissions.html

# Utils functions
symlink () {
    if [ -f $1 ]; then
        echo "Symlinking $1 ---> $2"
        ln -s $1 $2
    fi
}

if [ ${OPCACHE_USE_PRELOAD} = 'true' ]; then
    symlink "/conf/php-preload.ini" "/usr/local/etc/php/conf.d/51-php-preload.ini"
fi

echo "Copying /etc/nginx/conf.d/nginx.conf.template ---> /etc/nginx/conf.d/app.conf"
cp /etc/nginx/conf.d/nginx.conf.template /etc/nginx/conf.d/app.conf

# Fix permissions (see above link)
chmod -R 777 var
