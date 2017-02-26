# Serve PHP via Nginx and the FastCGI Process Manager (FPM)

This short how to will take you through how to set up your own web server with
PHP and Nginx. Some of the commands are specific to Ubuntu OS's.

## Install packages

`sudo apt-get install php7.0 php7.0-fpm nginx` will pull in the basic packages
you will need. There are many others that come in handy. `apt-cache search php`
will show what is available in terms of php modules.

## Sanity checks

`php -v` at a terminal should tell you that you now have Php installed.
Similarly browsing to localhost, should show you the Nginx welcome page.

## Update hosts file

Edit `/etc/hosts` to contain a line for your new local website.

    127.0.0.1       practice.local

The column on the right contains the URL, it can be anything. Your computer will
check this file to resolve names before checking with an external DNS. This URL
will be referenced in the Nginx config.

## Create web root

On Ubuntu systems `/var/www` is where sites live by default. So create a new
directory there with `sudo mkdir /var/www/practice`. This directory will be
referenced when we define the Nginx config. Create an index.php file with:

    <?php
    phpinfo();

### File permissions

Change the file permissions of your new directory. Do `sudo chown -R
www-data:www-data /var/www/practice`. This will actually change ownership to the
web server owner. This is the default user for Nginx and for Php-FPM.

## Inspect PHP-FPM config

Check the config file for PHP-FPM, which can be found at
`/etc/php/7.0/fpm/pool.d/www.conf` when it is installed via apt-get. Look for
the listen directive `listen = /run/php/php7.0-fpm.sock` and note it down. We
will need this when defining the Nginx server block.

## Pre-flight check

Going to `practice.local` in a browser should now give us a 502 Bad Gateway
response.

## Configure a server block

Nginx uses server blocks to configure the domains it serves. Delete the default
server block, or move it to your home directory to inspect it at leisure. And
also delete the link to it.
    
    sudo mv /etc/nginx/sites-available/default ~
    sudo rm /etc/nginx/sites-enabled/default

Then add the following code to a new site config file:

    
    server {
        listen 80;
        server_name practice.local;

        root /var/www/practice;
        index index.php;

        location / {
            try_files $uri $uri/ /index.php;
        }

        location ~ \.php$ {
            include fastcgi.conf;
            fastcgi_pass unix:/run/php/php7.0-fpm.sock;
        }
    }

## Create a sym link to the nginx config

Do `sudo ln -s /etc/nginx/sites-available/practice
/etc/nginx/sites-enabled/practice` and then `sudo service nginx reload`. To hook
up your new nginx config.

## Success!

Visit practice.local in the browser should show the Php info page.
