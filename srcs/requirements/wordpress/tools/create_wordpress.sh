#!/bin/sh

if [ -f ./wordpress/wp-config.php]
then
    echo "wordpress already downloaded"
else
    wget https://wordpress.org/latest.tar.gz
    tar -xzvf latest.tar.gz
    rm -rf latest.tar.gz

    rm -rf /etc/php/7.3/fpm/pool.d/www.conf
    mv ./www.conf /etc/php/7.3/fpm/pool.d/

    cd /var/www/html/wordpress
    sed -i "s/username_here/$MY_SQL_USER/g" wp-config-sample.php
    sed -i "s/password_here/$MY_SQL_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample-php
    sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample-php
    mv wp-config-sample.php wp-config.php
fi

exec "$@"