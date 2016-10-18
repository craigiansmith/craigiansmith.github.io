---
layout: default
title: Set up an HTTPS Server
---
# Set up an HTTPS Server
This is a quick how-to about setting up a HTTPS server for SSL connections utilising the free certbot tool by the Electronic Frontier Foundation. You should be able to follow this guide as is if using nginx as your webserver on a ubuntu machine. I make no claims or guarantees about the security, usefulness or reliability of the guide, it is merely what worked for me and could be a useful starting point.

The starting point for this guide is that you have nginx installed on a ubuntu machine and that you are serving a website through a custom domain. Then you are ready to serve your website securely using encryption. Let's get started.

## Get an SSL certificate using certbot.[^1] 

Getting an SSL certificate used to either cost money or be a difficult process. Not any more! Thanks to the EFF there is now a simple solution that works on Unix-ish systems, and does so simply and easily. 

Install certbot on your web server[^2]:

    wget https://dl.eff.org/certbot-auto
    # It is sensible to read through any file you download from the Internet
    # before you make it executable. So go ahead, read through it
    # and get an idea about what the script will do.
    chmod a+x certbot-auto
    mv certbot-auto /usr/local/bin

Now certbot will be in your path. Don't run it without arguments, you need to direct it to your web servers.

    certbot-auto certonly --webroot -w /path/to/web/public -d domain1.com -d extra.domain.com -w /path/to/second/web/public -d domain2.com

`--webroot` uses the webroot plugin which will help certbot find your config for the web sites you tell it about. 
`-w` specifies where the root directory lives. This might not be the top level directory of your app, if it has a public folder use that. Before running the command do a quick check by creating a .well-known directory in the root directory. Put a file in it. See if you can access it from the web. If you can, all good, if not you will need to change your server config to allow that to happen.
`-d` specifies each domain and sub-domain that points to the previously specified web root.

Certbot will then proceed to verify the server and download certificates. Links to the certificates are created in `/etc/letsencrypt/live/<domain>/`.[^3] The files that we need for nginx are `chain.pem`, `fullchain.pem`, and `privkey.pem`. The directory named after your domain is hidden. To eyeball that the files are there do `sudo ls /etc/letsencrypt/live/<tab>/`. In any case, Certbot will give you a congratulations message if successful, and complain if not.

## Install OpenSSL
Make sure you have OpenSSL install by running `openssl version` in your terminal.

We will need OpenSSL 1.0.2 in order to use the fullchain certificate that letsencrypt provides. On ubuntu 14.04 this means we need to add a new repository that has more recent packages.[^4]

    sudo add-apt-repository -y ppa:ondrej/php
    sudo apt-get update
    sudo apt-get upgrade openssl
    openssl version

You should see that version 1.0.2 or later has been installed.

Third
http://nginx.org/en/docs/beginners_guide.html
http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_certificate
Configure your server blocks to listen for https connections.

Fully configuring nginx server blocks is beyond the scope of this post, but here's what you need to do to get going.
server {
        # Listen on the standard port for SSL connections, we can rely on nginx's defaults here
        listen 443 ssl;

        # These three key value pairs are all required for https connections.
        # They specify the type of file and its location.
        ssl_trusted_certificate /etc/letsencrypt/live/plannd.com.au/chain.pem;
        ssl_certificate /etc/letsencrypt/live/plannd.com.au/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/plannd.com.au/privkey.pem;

        # List the domains that resolve here
        server_name plannd.com.au www.plannd.com.au;

        # Specify the directory where files will be served from
        root /var/www/live/public;
        index index.php index.html index.htm;


        location / {
                try_files $uri $uri/ /index.php$is_args$args;
        }

        # pass the PHP scripts to the FastCGI server listening on /var/run/php/php7.0-fpm.sock
        location ~ \.php$ {
                try_files $uri /index.php =404;
                fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
                fastcgi_index index.php;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                include fastcgi_params;
        }
}

Finally
Configure Nginx to always use https.
http://www.cyberciti.biz/faq/linux-unix-nginx-redirect-all-http-to-https/
# Http server redirects all request to secure server
server {
        listen 80;
        listen [::]:80 ipv6only=on default_server;

        server_name plannd.com.au www.plannd.com.au;
        rewrite ^ https://$server_name$request_uri? permanent;
}

Do this for as many server blocks as you use. Keep in mind the resources used to serve each one, so that you don't overload your server.

### References
[^1]: [Getting started with Let's Encrypt](https://letsencrypt.org/getting-started/)
[^2]: [Certbot - Nginx on Ubuntu Trusty](https://certbot.eff.org/#ubuntutrusty-nginx)
[^3]: [Certbot - Where are my certificates?](https://certbot.eff.org/docs/using.html#where-are-my-certificates)
[^4]: [Alex Bouma - Nginx with OpenSSL](http://alex.bouma.me/recompile-nginx-with-openssl-1-0-2-for-http-2-via-alpn-ubuntu-14-04/)
