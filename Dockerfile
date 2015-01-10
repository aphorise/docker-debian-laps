FROM debian:wheezy
##// 7.7 @ time of writting.
ENV DEBIAN_FRONTEND noninteractive
##///*******************************************************/
##//------------------------------------------------
##// Set timezone where not UTC "zoneinfo" dir for complete list.
##//------------------------------------------------
#//RUN cp /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

##//------------------------
##// Append apt for contrib, none-free, etc...
##//------------------------------------------------
#//RUN echo "deb http://http.debian.net/debian wheezy stable contrib non-free wheezy-backports main unstable" > /etc/apt/sources.list.d/wheezy-full.list

##//------------------------------------------------
##// Do update, upgrade (which may not be needed) & install:
##//------------------------------------------------
RUN apt-get update -y && apt-get -y upgrade
RUN apt-get install -y apache2 curl php5 libssh2-php php5-curl php5-memcached php5-mysqlnd php5-adodb php5-gd php-apc php5-pgsql

##//------------------------------------------------
##// Enable apache mods & Override's for apps. 
##//------------------------------------------------
RUN sed -i "s/AllowOverride None/AllowOverride ALL/" /etc/apache2/sites-enabled/000-default
RUN a2enmod php5 && a2enmod rewrite && service apache2 reload

##//------------------------------------------------
##// Inject default 200 app with .htaccess
##//------------------------------------------------
RUN rm /var/www/index.html && \
echo "<?php \$_S=&\$_SERVER; if (isset(\$_GET['!_debug'])) phpinfo(); else if (isset(\$_GET['!_who'])) { echo 'IAM:'.\$_S['SERVER_NAME'].' - OF:'.\$_S['SERVER_ADDR'].'<br>-UR:'.\$_S['REMOTE_ADDR'].' - YOF:'.\$_S['HTTP_USER_AGENT']; }	else http_response_code(200); ?>" > /var/www/index.php && \
echo "FallbackResource /index.php\n#//^ requests all to index.php, otherwise use targeted ErrorDocumentscodes:\n#//ErrorDocument 404 /index.php" > /var/www/.htaccess
##//------------------------------------------------

ENV APACHE_RUN_USER=www-data APACHE_RUN_GROUP=www-data APACHE_LOG_DIR=/var/log/apache2 APACHE_LOCK_DIR=/var/lock/apache2 APACHE_PID_FILE=/var/run/apache2.pid
EXPOSE 80
CMD ["/usr/sbin/apachectl", "-DFOREGROUND"]
##//------------------------------------------------
##///*******************************************************/

##//////////////////////////////////////////////////////////////////
# build: docker build -t debian/laps200app .
# run: docker run -p 80:80 -p 443:443 -it --detach --name=laps200app debian/laps200app
# cli: docker run -p 80:80 -p 443:443 -it --rm --name=laps200app debian/laps200app
##//////////////////////////////////////////////////////////////////
