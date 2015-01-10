#__Debian__ ``L``inux ``A``pache ``P``H5 ``S``tack (__*``LAPS``*__) Docker
## Common Development Utilities  
[docker.io](http://docker.io \"Docker\") Dockerfile (_**Debian**:Wheezy 7.7_) full PHP & HTTPD development environment with common tools such as:
```
build-essential software-properties-common pkg-config autoconf \
libtool automake pkg-config cmake python nano vim git htop wget \
nload links2 rsync openssh-client tree mc tmux screen nmap unzip curl 
```
Includes a minimal application using __``index.php``__& __``.htaccess``__ from [__*``laps200app``*__](https://github.com/aphorise/docker-debian-laps/tree/master/laps200app "laps200app-on-github") that unconditional returns a [__HTTP 200 OK__](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html \"rfc2616\") response in verbose mode when run via **CLI**: 
```sh
docker run -p 80:80 -p 443:443 -it --rm --name=lapsdev debian/lapsdev
```


Additional GET-Parameters: _``!_debug``_ (_php5info_)  & _``!_who``_ (_IP_ & _hostname_) can be passed in the URL for additional debugging - eg:
```
http://127.0.0.1/?!_who
http://127.0.0.1/this_is_404/no_path/?!_debug 
```

``Dockerfile`` is standalone containing all _build_ & _run_ instructions:
```sh
cat Dockferfile
```
Adjust leftmost ``-p`` numbers if local ``ports``: **80** (http) & **443** (https) are in use on testing machine - to use **_81_** & **_444_** bound to __*80*__ & __*443*__ in container:
```sh
docker run -p 81:80 -p 444:443 -it --rm --name=lapsdev debian/lapsdev
```
Default ``/var`` paths used for __apache2__ with default ``/var/www/index.php`` 

To shell into image via ``/bin/bash`` simply append instruction to run command eg: 
```sh
docker run -p 81:80 -p 444:443 -it --rm --name=laps debian/lapsdev /bin/bash
```
