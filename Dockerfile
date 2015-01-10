FROM debian:wheezy
##// 7.7 @ time of writting.
ENV DEBIAN_FRONTEND noninteractive
##///*******************************************************/
##//------------------------------------------------
##// Set timezone where not UTC "zoneinfo" dir for complete list.
##//------------------------------------------------
#//RUN cp /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

##//------------------------------------------------
##// Append [as needed] apt for contrib, none-free, etc...
##//------------------------------------------------
#//RUN echo "deb http://http.debian.net/debian wheezy stable contrib non-free wheezy-backports main unstable" > /etc/apt/sources.list.d/wheezy-full.list

##//------------------------------------------------
##// Do update, upgrade (which may not be needed) & install:
##//------------------------------------------------
RUN apt-get update -y && apt-get -y upgrade
RUN apt-get install -y dialog aptitude apt-transport-https \
build-essential software-properties-common python-software-properties \
pkg-config autoconf libtool automake pkg-config cmake python \ 
nano vim git htop wget nload links2 rsync openssh-client tree mc tmux screen nmap unzip \
apache2 curl php5 libssh2-php php5-curl php5-memcached php5-mysqlnd php5-adodb php5-gd php-apc php5-pgsql

##//------------------------------------------------
##// Install: GO (1.4+) programming language
##//------------------------------------------------
RUN wget https://storage.googleapis.com/golang/go1.4.linux-amd64.tar.gz && \
tar -C /usr/local -xzf go1.4.linux-amd64.tar.gz && rm -f go1.4* && \
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile

##//------------------------------------------------
##// Install: Node.js 0.10.3+
##//------------------------------------------------
RUN echo "deb https://deb.nodesource.com/node wheezy main\ndeb-src https://deb.nodesource.com/node wheezy main" > /etc/apt/sources.list.d/nodesource.list
RUN apt-get update -y && apt-get install nodejs -y --force-yes

##//------------------------------------------------
##// Enable apache mods & Override's for apps
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
##// STARTUP INIT: script start apache & tail log to see incoming requests.
##//------------------------------------------------
RUN echo "/usr/sbin/apachectl start && tail -f /var/log/apache2/access.log" > /start_init.sh && chmod +x /start_init.sh

ENV APACHE_RUN_USER=www-data APACHE_RUN_GROUP=www-data APACHE_LOG_DIR=/var/log/apache2 APACHE_LOCK_DIR=/var/lock/apache2 APACHE_PID_FILE=/var/run/apache2.pid
EXPOSE 80
CMD ["/bin/bash", "/start_init.sh"]
##//------------------------------------------------
##///*******************************************************/

##//////////////////////////////////////////////////////////////////
# build: docker build -t debian/lapsdev .
# run: docker run -p 80:80 -p 443:443 -it --detach --name=lapsdev debian/lapsdev
# cli: docker run -p 80:80 -p 443:443 -it --rm --name=lapsdev debian/lapsdev
##//////////////////////////////////////////////////////////////////
