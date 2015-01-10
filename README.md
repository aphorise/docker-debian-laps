#__Debian__ ``L``inux ``A``pache ``P``H5 ``S``tack (__*``LAPS``*__) Docker
## 200 OK - App
Simple [docker.io](http://docker.io \"Docker\") Dockerfile (_**Debian**:Wheezy 7.7_) PHP  template (__``index.php``__) with __``.htaccess``__. An unconditional [__HTTP 200 OK__](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html \"rfc2616\") response is always provided for any request using ```FallbackResource``` in ``.htaccess`` to ``index.php``; both files are in-lined described within ```Dockerfile```. 

Additional GET-Parameters: _``!_debug``_ (_php5info_)  & _``!_who``_ (_IP_ & _hostname_) can be passed in the URL for additional debugging - eg:
```
http://127.0.0.1/?!_who
http://127.0.0.1/this_is_404/no_path/?!_debug 
```

``Dockerfile`` is standalone containing all _build_ & _run_ instructions:
```sh
cat Dockferfile
# build: docker build -t debian/laps200app .
# run: docker run -p 80:80 -p 443:443 -it --detach --name=laps200app debian/laps200app
# cli: docker run -p 80:80 -p 443:443 -it --rm --name=laps200app debian/laps200app
```
Adjust leftmost ``-p`` numbers if local ``ports``: **80** (http) & **443** (https) are in use on testing machine - for example:
```sh
docker run -p 81:80 -p 444:443 -it --rm --name=laps debian/laps
```
Default ``/var`` paths used for __apache2__ with default ``/var/www/index.php`` 

To shell into image via ``/bin/bash`` simply append instruction to run command eg: 
```sh
docker run -p 81:80 -p 444:443 -it --rm --name=laps debian/laps /bin/bash
```
See [__*``lapsdev``*__](https://github.com/aphorise/docker-debian-laps/tree/master/lapsdev "lapsdev-on-github") for a fully functioning version in verbose mode.
