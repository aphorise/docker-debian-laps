FROM debian:wheezy
##// 7.7 @ time of writting. 
ENV DEBIAN_FRONTEND noninteractive
##///*******************************************************/
##//------------------------------------------------
##// Set timezone where not UTC "zoneinfo" dir for complete list. 
##//------------------------------------------------
#//RUN cp /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

##//------------------------------------------------
##// Append apt for contrib, none-free, etc...
##//------------------------------------------------
#//RUN echo "deb http://http.debian.net/debian wheezy stable contrib non-free wheezy-backports main unstable" > /etc/apt/sources.list.d/wheezy-full.list

##//------------------------------------------------
##// Do update, upgrade (which may not be needed) & install stack essentials:
##//------------------------------------------------
RUN apt-get update -y && apt-get -y upgrade
RUN apt-get install -y apache2 curl php5 libssh2-php php5-curl php5-memcached php5-mysqlnd php5-adodb php5-gd php-apc php5-pgsql

##//------------------------------------------------
##// Enable apache mods & Override's for apps. 
##//------------------------------------------------
RUN sed -i "s/AllowOverride None/AllowOverride ALL/" /etc/apache2/sites-enabled/000-default
RUN a2enmod php5 && a2enmod rewrite && service apache2 reload
##//------------------------------------------------

ENV APACHE_RUN_USER=www-data APACHE_RUN_GROUP=www-data APACHE_LOG_DIR=/var/log/apache2 APACHE_LOCK_DIR=/var/lock/apache2 APACHE_PID_FILE=/var/run/apache2.pid
EXPOSE 80 443
CMD ["/usr/sbin/apachectl", "-DFOREGROUND"]
##//------------------------------------------------
##///*******************************************************/

##//////////////////////////////////////////////////////////////////
# build: docker build -t debian/laps .
# run: docker run -p 80:80 -p 443:443 -it --detach --name=laps debian/laps
# cli: docker run -p 80:80 -p 443:443 -it --rm --name=laps debian/laps
##//////////////////////////////////////////////////////////////////
